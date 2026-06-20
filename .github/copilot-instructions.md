# Open Weather Vision — Copilot Instructions

## 1. Project Overview

**Open Weather Vision (owvision)** is a self-hostable, open-source weather data platform. It solves the problem of personal weather station owners having no easy, private way to record, archive, analyze, and share their station's data. Most commercial alternatives are cloud-only and lock the user's data away.

owvision runs entirely on local hardware (e.g. a Raspberry Pi), giving the owner full control. Key features:

- **Recording**: Continuously polls connected weather stations and buffers incoming sensor readings.
- **Archiving**: Persists all readings in a local SQLite database with full history.
- **Analysis**: Computes periodic statistics (highs/lows, daily, weekly, monthly aggregates).
- **Live data**: Streams real-time sensor updates to connected clients via WebSocket.
- **REST API**: Exposes all archived and live data through a clean, secured HTTP API.
- **Dashboard**: A modern Flutter GUI that visualizes live and historical data, supports themes, light/dark mode, and includes an admin panel for managing stations.
- **Extensible**: Station adapters ("interfaces") are community-written and language-agnostic via gRPC, so any weather station can be integrated.

The entire backend is written in **Dart**. The dashboard is **Flutter**. A unified Dart workspace keeps dependencies consistent across all components.

---

## 2. Subcomponents

### `./daemon` — The Central Processing Unit

The daemon is the heart of the system. It owns the database and is the single source of truth for all weather data. Its responsibilities are:

- **Storing** sensor readings sent by recorders into a SQLite database.
- **Computing** periodic history records (aggregated snapshots at configurable intervals) from the incoming live stream.
- **Serving** the REST API — the primary interface for any consumer (dashboard, third-party tools).
- **Streaming** live sensor state changes over WebSocket so clients get real-time updates without polling.
- **Exposing a gRPC service** (`DaemonService`) that recorders connect to in order to register stations and push sensor data.
- **Managing tokens** for authentication and access control across all roles.

It also ships a CLI tool (`owvi`) for station management without a GUI.

### `./recorder` — The Flexible Input Buffer

The recorder is a lightweight, robust process that runs close to the weather station (e.g. on the same Raspberry Pi as the interface). Its responsibilities are:

- **Discovering** a running station interface on `localhost:50051` via gRPC auto-detection.
- **Polling** the interface at configured intervals and collecting raw sensor readings.
- **Buffering** readings in an in-memory queue so no data is lost during transient daemon connection failures.
- **Uploading** buffered readings in batches to the daemon's gRPC service.
- **Adding virtual sensors** (e.g. weather condition codes from Open-Meteo) on top of physical sensor data.

The recorder is intentionally stateless regarding historical data — it only forwards; the daemon decides what to persist.

### `./shared` — Shared Kernel

A Dart package imported by all components. Contains:

- **Models** with JSON serialization (sensors, stations, token roles, sensor states).
- **Unit system**: typed units for all physical quantities (temperature, humidity, pressure, wind, precipitation, etc.) with conversion support.
- **Logger**: a shared logging abstraction used throughout the codebase.
- **gRPC generated code**: compiled Dart stubs from `protos/recorder.proto` — used by both daemon and recorder.
- **Utilities**: home directory resolution, shell command runner, timer utilities.

### `./dashboard` — The Graphical User Interface

A Flutter application that is the entry point for end users. Communicates exclusively with the daemon's REST API and WebSocket. Features:

- Live sensor readings displayed in real time.
- Historical charts for any time range and sensor.
- Admin panel for creating/deleting stations and managing tokens.
- Responsive layout; supports desktop, tablet, and mobile viewports.
- Light and dark themes with full customization.

### `./builder` — Internal Build Tooling

A Dart CLI used during development and CI to orchestrate multi-component build steps: code generation, protoc compilation, and cross-component compilation. Not part of the runtime system.

---

## 3. Architecture Overview

### How Components Work Together

```
Weather Station
      │  (vendor-specific protocol)
      ▼
  Interface (gRPC service on :50051)
      │  StationInterface proto
      ▼
   Recorder  ──────────────────────────────────────────┐
      │  DaemonService gRPC                             │
      ▼                                                 │
   Daemon  ←──── REST API + WebSocket ────►  Dashboard  │
      │                                                 │
   SQLite                                  (same host or
                                            over network
                                            via Caddy)
```

- **Interfaces** are the hardware adapters. Each interface implements a gRPC service (`StationInterface`) on `localhost:50051`. They are language-agnostic and community-written.
- **The recorder** bridges the interface to the daemon. It runs on the same machine as the interface and connects outward to the daemon.
- **The daemon** receives data via gRPC from one or many recorders, stores it, and serves it outward via REST/WebSocket.
- **The dashboard** is a pure consumer of the daemon's REST API. It has no direct connection to the recorder or interface.
- **Caddy** acts as a reverse proxy in front of the daemon's REST API for external (non-localhost) access. The daemon itself only binds to `127.0.0.1`.

### Data Flow

1. A sensor reading is fetched by the recorder from the interface at a configured `recordIntervalSeconds`.
2. The recorder places it in an in-memory queue and periodically flushes the queue to the daemon via gRPC.
3. The daemon's `LiveService` receives the reading, updates its in-memory live state, and emits an event.
4. `HistoryCreatorService` listens to live events and writes a history record to SQLite at `historyIntervalSeconds` granularity.
5. The WebSocket server pushes the updated live state to all subscribed dashboard clients.
6. The REST API serves historical data from SQLite on demand.

---

## 4. Subcomponent Architecture

### Daemon

The daemon is structured in strict horizontal layers:

```
HTTP Request
    │
    ▼
Router  (lib/routers/)        — shelf_router, maps URL patterns to controllers
    │
    ▼
Controller  (lib/controllers/) — parses request params, delegates to services, returns Response
    │
    ▼
Service  (lib/services/)       — business logic; emits domain events via EventEmitter
    │
    ▼
Repository  (lib/repositories/) — Drift queries only; no business logic
    │
    ▼
Database  (lib/database/)       — Drift Table definitions + AppDatabase singleton
```

The middleware pipeline wraps the entire router stack:
`logRequests → rateLimiter (60 req/min) → defaultHeaders → authMiddleware → router`

Authentication is role-based. The `authMiddleware` validates the Bearer token and stores the resolved `Token` object in `request.context['token']`. Controllers check the role (`TokenRole`: `viewer`, `admin`, `recorder`, `initialize`) before acting.

The daemon also runs a **gRPC server** (`DaemonService`) on a separate port, used exclusively by recorders to register stations and push sensor readings.

Live state is managed by `LiveService`, which holds the latest reading for each sensor in memory. `HistoryCreatorService` and the WebSocket broadcaster both subscribe to live state changes via `events_emitter`.

### Recorder

The recorder is a single long-running process built around `RecorderService`:

1. On startup it reads `RecorderConfig` (config file) and connects to both the local interface gRPC and the daemon gRPC.
2. It fetches the `StationDefinition` from the interface and registers/syncs the station with the daemon.
3. It schedules `DriftFreeTimer` tasks — one per sensor — that poll the interface at `recordIntervalSeconds` intervals and push readings into a `DataQueue`.
4. A separate flush timer drains the `DataQueue` and sends batches to the daemon via gRPC.
5. On connection errors the queue retains data until the connection recovers.

Virtual sensors (e.g. Open-Meteo weather condition) are added as synthetic sensor definitions alongside physical sensors.

### Dashboard

The dashboard follows Flutter's **BLoC/Cubit** pattern for state management:

- Each screen or feature lives under `lib/features/<feature>/` with its own Cubit and UI widgets.
- A global `NavigationCubit` handles top-level routing.
- All API calls go through `owvision_daemon_client_dart` (auto-generated from the OpenAPI spec). Live updates come over WebSocket.
- `AppStateObserver` listens to auth/connection state across the whole app.

### Shared

Shared is a pure library package — no `main`, no services. Everything is importable directly. The most important pieces:

- `shared/lib/models/` — serializable domain models (`Sensor`, `SensorState`, `StationLiveState`, `TokenRole`, etc.)
- `shared/lib/units/` — the unit system; every sensor value has a typed `Unit` with conversion support
- `shared/lib/grpc/` — generated gRPC stubs (do not edit; regenerate with `protoc`)
- `shared/lib/logger/logger.dart` — the single shared logger instance

---

## 5. Code Guidelines

- _Documented_: every public class and method must have a doc comment. keep the documentation clear and concise.
- _Typed_: use strong typing everywhere. Avoid `dynamic` and `var`.
- _Modular_: keep functions small and focused. If a function exceeds ~20-40 lines, consider refactoring.
- _Consistent style_: follow the Dart style guide. Use `dart format` and `dart analyze` to maintain code quality.
- _Error handling_: use `try/catch` blocks around any code that can throw. Log errors with the shared logger.
- _Maintainable and extensible_: design with future features in mind. Avoid hardcoding values; use configuration where appropriate.
- _Robust_: handle edge cases and potential failure points gracefully. The system should never crash due to unhandled exceptions or invalid input.
