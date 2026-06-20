---
name: recorder
description: >
    Deep reference for the owvision recorder component (`./recorder`). Use when working on
    the recorder's sensor polling loop, data queue, gRPC connections, virtual sensors,
    config/status files, CLI (owrec), or station interface discovery. Covers architecture,
    service roles, data flow, and all key libraries.
---

# Recorder — Component Reference

## 1. Role in the Big Picture

The recorder is the **input buffer** between a weather station and the daemon. It sits
close to the hardware (typically on the same Raspberry Pi as the station interface),
continuously polls sensor values, and forwards them reliably to the daemon.

Its defining characteristic is **resilience**: it never loses readings, even when the
daemon is temporarily unreachable, by buffering all data in an in-memory queue until
a successful upload is confirmed.

### Responsibilities

- **Discover** the local station interface (gRPC service on `localhost:50051`).
- **Register** (or sync) the station definition with the daemon on first startup.
- **Poll** each sensor at its configured `recordIntervalSeconds` interval.
- **Buffer** readings in a bounded in-memory `DataQueue` (max 5 000 items, FIFO drop-oldest).
- **Flush** buffered batches (up to 20 items) to the daemon every 10 seconds.
- **Add virtual sensors** (e.g. weather condition from Open-Meteo) alongside physical sensors.
- **Track connection status** to the interface, daemon, and Open-Meteo in a persistent status file.

### Interfaces with Other Components

| Direction | Protocol                  | Counterpart                           | Purpose                                                |
| --------- | ------------------------- | ------------------------------------- | ------------------------------------------------------ |
| Inbound   | gRPC (`StationInterface`) | Station interface (`localhost:50051`) | Fetch `StationDefinition` and per-sensor `SensorState` |
| Outbound  | gRPC (`DaemonService`)    | Daemon                                | Register station, push batched sensor updates          |
| Outbound  | HTTPS REST                | Open-Meteo public API                 | Fetch weather condition code for virtual sensor        |
| Shared    | Dart package import       | `./shared`                            | gRPC stubs, domain models, `DriftFreeTimer`, logger    |

The recorder **never communicates with the dashboard**. It has no REST API of its own.

---

## 2. Architecture

### Startup and Recovery Loop (`RecorderService.start()`)

```
start()
  │
  ├─ Read RecorderConfig from ~/.owvision/recorder_config.json
  ├─ Connect to interface gRPC (localhost:interfaceGrpcPort)
  ├─ Connect to daemon gRPC  (daemonGrpcHost:daemonGrpcPort)
  │
  ├─ GetStationDefinition from interface
  │
  ├─ stationId == null?  →  CreateStation on daemon  →  save stationId to config
  │   else               →  GetStation, compare version
  │                          version changed? → UpdateStation
  │
  ├─ For each sensor:
  │    ├─ _fetchSensor() immediately (initial reading)
  │    └─ Schedule DriftFreeTimer at recordIntervalSeconds
  │
  ├─ _processLatestBatch() immediately
  └─ Schedule DriftFreeTimer every 10 s → _processLatestBatch()

On any error → pause() all timers → wait 10 s → restart()
```

### Sensor Fetch (`_fetchSensor`)

Each sensor fetch runs under a **per-sensor async lock** (`_sensorFetchLocks`) so that
if a slow fetch is still in flight when the next interval fires, the new fetch waits
rather than running concurrently:

- **Physical sensors** → `StationInterface.GetSensorState(name)` → enqueue result.
- **Virtual open-meteo sensor** → query Open-Meteo API for `weather_code` at the station's
  coordinates → enqueue result. Interval is fixed at 15 minutes.

### Data Queue (`DataQueue`)

An in-memory FIFO queue inside `RecorderService`. Key properties:

- **Max size**: 5 000 items. When full, the oldest update is dropped and a warning is logged.
- **Batch size**: up to 20 items per flush.
- **Item identity**: every `UpdateSensorRequest` is assigned an auto-incrementing `updateId`
  before enqueuing. The daemon echoes back the `updateId` in its response, which is how the
  queue knows what to remove after a successful flush.

The queue is **in-memory only** — it does not survive a process restart. This is acceptable
because the station interface will provide fresh readings on next startup.

### Batch Flush (`_processLatestBatch`)

Runs every 10 seconds (and once immediately on startup):

1. `takeBatch()` — peek at up to 20 items without removing them.
2. `DaemonService.UpdateSensors(batch)` — send to daemon.
3. If successful: `removeBatch(processedIds)` — permanently remove confirmed items.
4. If gRPC error: log warning, keep items in queue, try again next cycle.

### Virtual Sensor — Open-Meteo Weather Condition

When `enableVirtualWeatherConditionSensor: true` in config, the recorder injects an extra
`SensorDefinition` named `current_weather_openmeteo` with `element: weatherCode` into the
`StationDefinition` before registering with the daemon. This sensor is then polled like any
other, but its value comes from the Open-Meteo `weather_code` current variable instead of
the physical interface.

### Status Tracking (`StatusService` + `RecorderStatus`)

`StatusService` is a `@singleton` that writes a `RecorderStatus` JSON file to
`~/.owvision/recorder_status.json` after every connection attempt. The fields it tracks:

| Field                       | Meaning                                      |
| --------------------------- | -------------------------------------------- |
| `stationConnected`          | Last interface gRPC call succeeded           |
| `daemonConnected`           | Last daemon gRPC call succeeded              |
| `openMeteoConnected`        | Last Open-Meteo HTTP call succeeded          |
| `latestStationConnection`   | Timestamp of last successful interface call  |
| `latestDaemonConnection`    | Timestamp of last successful daemon call     |
| `latestOpenMeteoConnection` | Timestamp of last successful Open-Meteo call |

This file is read by the `owrec status` CLI command to display live health without needing
the recorder process to be directly inspectable.

### Configuration (`RecorderConfig`)

Read from `~/.owvision/recorder_config.json` at startup. Falls back to safe defaults if the
file is missing (new installation). Key fields:

| Field                                 | Default     | Purpose                                                                    |
| ------------------------------------- | ----------- | -------------------------------------------------------------------------- |
| `interfaceGrpcHost`                   | `127.0.0.1` | Interface gRPC host                                                        |
| `interfaceGrpcPort`                   | `50051`     | Interface gRPC port                                                        |
| `daemonGrpcHost`                      | `0.0.0.0`   | Daemon gRPC host (public, via Caddy)                                       |
| `daemonGrpcPort`                      | `8081`      | Daemon gRPC public port                                                    |
| `daemonGrpcToken`                     | `""`        | Bearer token with `recorder` role                                          |
| `trustSelfSignedCertificate`          | `false`     | Whether to accept the daemon's self-signed TLS cert                        |
| `enableVirtualWeatherConditionSensor` | `true`      | Inject Open-Meteo virtual sensor                                           |
| `stationId`                           | `null`      | Persisted after first `CreateStation`; prevents re-registration on restart |

### CLI (`owrec`)

The recorder ships a CLI (`owrec`) in `lib/cli/`. It does **not** call the daemon's REST API;
instead it reads/writes local config and status files and manages a background OS service.
Commands:

| Command        | Purpose                                                          |
| -------------- | ---------------------------------------------------------------- |
| `init`         | Registers the recorder as an OS background service and starts it |
| `authenticate` | Interactively sets `daemonGrpcToken` in the config file          |
| `config`       | View or edit config values                                       |
| `status`       | Print connection status from the status file                     |
| `reset`        | Remove config and status files, unregister the OS service        |
| `restart`      | Restart the background service                                   |
| `update`       | Update the recorder binary                                       |

### gRPC Proto (`shared/protos/recorder.proto`)

The recorder uses two services defined in the same proto file:

**`DaemonService`** (recorder → daemon, outbound):

| RPC                                   | Purpose                                                                        |
| ------------------------------------- | ------------------------------------------------------------------------------ |
| `CreateStation(StationDefinition)`    | Register a new station; returns the created `Station` with assigned sensor IDs |
| `GetStation(GetStationRequest)`       | Fetch the current station definition from the daemon                           |
| `UpdateStation(UpdateStationRequest)` | Push a changed `StationDefinition` (version bump)                              |
| `UpdateSensors(UpdateSensorsRequest)` | Batch-upload sensor readings                                                   |
| `Ping(PingMessage)`                   | Health check                                                                   |

**`StationInterface`** (recorder → interface, local):

| RPC                      | Purpose                                   |
| ------------------------ | ----------------------------------------- |
| `GetStationDefinition()` | Retrieve the station's sensor definitions |
| `GetSensorState(name)`   | Retrieve the current value of one sensor  |

---

## 3. Libraries and Toolset

| Library                                 | Role                                                                      |
| --------------------------------------- | ------------------------------------------------------------------------- |
| `grpc`                                  | gRPC client for both `DaemonService` and `StationInterface`               |
| `fixnum`                                | `Int64` type required by protobuf-generated gRPC stubs                    |
| `protobuf`                              | Runtime support for generated proto message classes                       |
| `open_meteo`                            | Dart client for the Open-Meteo public weather API (virtual sensor)        |
| `injectable` + `get_it`                 | Dependency injection; wiring code-generated in `locator.config.dart`      |
| `json_annotation` + `json_serializable` | JSON serialization for `RecorderConfig` and `RecorderStatus`              |
| `args`                                  | CLI argument parsing for `owrec`                                          |
| `interact`                              | Interactive terminal prompts (e.g. `authenticate` command)                |
| `chalkdart`                             | Coloured terminal output                                                  |
| `logging`                               | Dart core logging; shared logger wraps this                               |
| `shared` (internal)                     | `DriftFreeTimer`, gRPC stubs, domain models, `getOwvisionHomeDirectory()` |

### `DriftFreeTimer` (from `shared`)

A self-correcting periodic timer that adjusts each interval based on actual elapsed time,
preventing schedule drift over long uptimes. Used for all sensor polling timers and the
batch flush timer. Prefer this over `Timer.periodic` anywhere a long-running fixed-interval
task is needed.

### Code Generation

After modifying `@singleton` / `@injectable` annotations or `@JsonSerializable` models,
run from `./recorder`:

```sh
dart run build_runner build
```

This regenerates:

- `locator.config.dart` — DI wiring
- `recorder_config.g.dart`, `recorder_status.g.dart` — JSON serialization
