---
name: daemon
description: >
    Deep reference for the owvision daemon component (`./daemon`). Use when working on the
    daemon's REST API, WebSocket, gRPC service, database schema, token auth, history recording,
    live sensor state, or CLI. Covers architecture, service roles, data flow, and all key libraries.
---

# Daemon — Component Reference

## 1. Role in the Big Picture

The daemon is the **central processing unit** of owvision. It is the single source of truth
for all weather data and the only component that owns the SQLite database.

### Responsibilities

- Receive live sensor readings from recorders via a **gRPC service**.
- Persist readings and compute periodic **history records** in a local SQLite database.
- Maintain the **live in-memory state** (latest reading per sensor per station).
- Serve all data through a **secured REST API** (archived history + live WebSocket stream).
- Manage **authentication tokens** with role-based access control.
- Configure **Caddy** as the reverse proxy for external (non-localhost) access.

### Interfaces with Other Components

| Direction | Protocol               | Counterpart             | Purpose                                              |
| --------- | ---------------------- | ----------------------- | ---------------------------------------------------- |
| Inbound   | gRPC (`DaemonService`) | Recorder                | Recorders register stations and push sensor readings |
| Outbound  | HTTP/REST + WebSocket  | Dashboard / third-party | Serve archived and live data                         |
| Outbound  | Caddy Admin API        | Caddy reverse proxy     | Configure TLS + public port forwarding at startup    |
| Shared    | Dart package import    | `./shared`              | Domain models, units, gRPC stubs, logger             |

The REST API binds to `127.0.0.1` only. All external traffic is routed through Caddy.
The gRPC service also binds locally; recorders on remote machines connect through the
Caddy-forwarded public gRPC port.

---

## 2. Architecture

### Startup Sequence (`runDaemon.dart`)

1. `fixLibsqlite()` — resolves the native SQLite library path at runtime.
2. `configureDependencies()` — bootstraps the get_it DI container.
3. `LiveService.start()` — starts the gRPC server for recorders.
4. `RestApiService.start()` — starts the HTTP server.
5. `CaddyService.tryToConfigure()` — pushes the Caddy config (retries until Caddy is ready).
6. `LiveSensorStateService.start()` — begins tracking live sensor state in memory.
7. `HistoryCreatorService.start()` — begins writing history records on live updates.
8. `TokenService.insertInitializationTokenIfThereIsNone()` — seeds the first-boot token.

### Layered HTTP Stack

```
HTTP Request
    │
    ▼
Middleware Pipeline
    logRequests → shelfLimiter (60 req/min) → defaultHeaders → authMiddleware
    │
    ▼
AppRouter  (lib/routers/app_router.dart)
    /api/v1/stations  →  StationRouter
    /api/v1/tokens    →  TokenRouter
    │
    ▼
Controller  (lib/controllers/)
    Parses request params, checks token role, delegates to services
    │
    ▼
Service  (lib/services/)
    Business logic; emits domain events via EventEmitter
    │
    ▼
Repository  (lib/repositories/)
    Drift ORM queries; no business logic
    │
    ▼
AppDatabase  (lib/database/database.dart)
    SQLite via Drift; tables: StationTable, SensorTable, TokenTable, HistoryTable
```

### Key Services and Their Roles

| Service                  | Role                                                                                                                                            |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `LiveService`            | Runs the gRPC server; receives readings from recorders and emits `sensor_update` / `station_create` events via `EventEmitter`                   |
| `LiveSensorStateService` | Subscribes to `LiveService` events; keeps the latest reading for each sensor in memory; pushes WebSocket updates to connected dashboard clients |
| `HistoryCreatorService`  | Subscribes to `LiveService` events; writes a raw history record to SQLite at `historyIntervalSeconds` cadence per sensor                        |
| `StationService`         | CRUD for stations; emits `station_create` / `station_delete` events so other services can react                                                 |
| `SensorService`          | Read-only access to sensor definitions                                                                                                          |
| `HistoryService`         | Queries historical records; builds `SensorHistory` objects for the REST API                                                                     |
| `TokenService`           | Generates and validates tokens; handles first-boot initialization token                                                                         |
| `ConfigService`          | Reads `~/.owvision/daemon_config.json` at startup; exposes `DaemonConfig` (ports, public hostname, `initialized` flag)                          |
| `CaddyService`           | Posts a Caddy JSON config to `http://127.0.0.1:2019/load` at startup; retries until Caddy accepts it                                            |
| `RestApiService`         | Assembles the shelf middleware pipeline and starts the HTTP server                                                                              |

### Service Base Classes

- **`StationBasedService`** — abstract base that calls `onStationCreate` / `onStationDelete`
  for every active station, reacting to `StationService` events. Use this when a service must
  track all stations dynamically.
- **`LiveBasedService`** (extends `StationBasedService`) — additionally subscribes to
  `LiveService` sensor update events per station. Use this when a service must react to every
  incoming sensor reading.

Both `LiveSensorStateService` and `HistoryCreatorService` extend `LiveBasedService`.

### Authentication

The REST API uses Bearer tokens. `authMiddleware` extracts the token from the
`Authorization: Bearer <token>` header (or from `Sec-WebSocket-Protocol` for WebSocket
clients) and resolves it to a `Token` object stored in `request.context['token']`.
Controllers read the role before acting. Roles: `viewer`, `admin`, `recorder`, `initialize`.

The gRPC service uses a per-call interceptor (`authInterceptor`) that validates a `recorder`-role
Bearer token, ensuring only authorised recorders can push data.

The `initialize` role is a special bootstrap role: when the daemon has never been set up
(`config.initialized == false`), it is treated as `admin` so the first user can log in and
create real tokens without prior credentials.

### Database Schema

Tables live in `lib/database/tables/`. `AppDatabase` registers all four:

| Table          | Key Columns                                                                                                 |
| -------------- | ----------------------------------------------------------------------------------------------------------- |
| `StationTable` | `id`, `name` (unique), `latitude`, `longitude`, `version`, `createdAt`                                      |
| `SensorTable`  | `id`, `stationId` (FK), `name`, `element`, `storageUnit`, `recordIntervalSeconds`, `historyIntervalSeconds` |
| `TokenTable`   | `id`, `token` (hashed), `role`                                                                              |
| `HistoryTable` | `id`, `sensorId` (FK), `value`, `createdAt`                                                                 |

Database file: `~/.owvision/data.sqlite` (resolved by `getOwvisionHomeDirectory()` from `shared`).

### REST API Routes

All routes are versioned under `/api/v1/`.

| Method   | Path                           | Role Required          | Description                   |
| -------- | ------------------------------ | ---------------------- | ----------------------------- |
| `GET`    | `/api/v1/stations`             | any                    | List all stations             |
| `GET`    | `/api/v1/stations/:id`         | any                    | Get a station                 |
| `GET`    | `/api/v1/stations/:id/live`    | any                    | WebSocket — live sensor state |
| `GET`    | `/api/v1/stations/:id/history` | any                    | Historical sensor data        |
| `POST`   | `/api/v1/tokens`               | `initialize` / `admin` | Generate a token              |
| `DELETE` | `/api/v1/tokens`               | `admin`                | Revoke tokens                 |

### CLI (`owvi`)

The `owvi` CLI runs as a **separate process** that calls the daemon's REST API over the network.
It does not import daemon services directly. Commands include: `init`, `authenticate`,
`gentoken`, `station`, `status`, `config`, `reset`, `restart`, `sample`, `update`.

---

## 3. Libraries and Toolset

| Library                                 | Role                                                                              |
| --------------------------------------- | --------------------------------------------------------------------------------- |
| `shelf` + `shelf_router`                | HTTP server and routing                                                           |
| `shelf_limiter`                         | Rate limiting middleware (60 req/min globally)                                    |
| `shelf_web_socket`                      | WebSocket upgrade inside shelf handlers                                           |
| `grpc`                                  | gRPC server (`DaemonService`) receiving recorder data                             |
| `drift` + `drift/native` + `sqlite3`    | ORM and SQLite database access; code-generated via `drift_dev`                    |
| `injectable` + `get_it`                 | Dependency injection; DI wiring is code-generated via `injectable_generator`      |
| `events_emitter`                        | In-process pub/sub for `sensor_update`, `station_create`, `station_delete` events |
| `json_annotation` + `json_serializable` | JSON serialization for models and config; code-generated                          |
| `dio`                                   | HTTP client used by `CaddyService` to configure the Caddy reverse proxy           |
| `crypto`                                | Token hashing                                                                     |
| `uuid`                                  | Token ID generation                                                               |
| `args`                                  | CLI argument parsing for `owvi`                                                   |
| `interact`                              | Interactive prompts in `owvi`                                                     |
| `chalkdart`                             | Coloured terminal output                                                          |
| `logging`                               | Dart core logging; shared logger wraps this                                       |

### Code Generation

All generated files end in `.g.dart` and must never be edited manually.
After modifying annotated classes, run from `./daemon`:

```sh
dart run build_runner build
```

This regenerates:

- `locator.config.dart` (injectable DI wiring)
- `*.g.dart` for all `@JsonSerializable` models
- `database.g.dart` (Drift database + query extensions)

### OpenAPI Specification

The REST API is specified in TypeSpec (`daemon/specification/main.tsp`).
The `owvision_daemon_client_dart` package used by the dashboard is **auto-generated** from
the compiled OpenAPI YAML. When adding or changing endpoints, update the TypeSpec first,
regenerate the spec, then regenerate the client.
