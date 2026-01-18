import "@typespec/http";
import "@typespec/versioning";

using Http;
using Versioning;

@service(#{ title: "Daemon REST API" })
@versioned(Versions)
@server("https://0.0.0.0:8080/api/v1")
@server("http://127.0.0.1:7070/api/v1")
namespace DaemonRestApi;

enum Versions {
  v1: "0.0.12"
}

model WeatherStation {
  id: int64;
  name: string;
  longitude: float64;
  latitude: float64;
  createdAt: string;
}

model Sensor {
  id: int64;
  element: SensorElement;
  name: string;
  recordIntervalSeconds: int64;
  historyIntervalSeconds: int64;
}

enum SensorElement{
  precipationAccumulated,
  precipationRate,
  snowHeight,
  pressure,
  temperature,
  windSpeed,
  windDirection,
  humidity,
  weatherCode,
  dewPoint,
  windChill
}

@error
model Error {
  code: ErrorCode;
  message: string;
}

enum ErrorCode{
  unauthorized: "unauthorized",
  notFound: "notFound",
  internalError: "internalError",
  badRequest: "badRequest"
}

enum TokenRole{
  admin: "admin",
  recorder: "recorder",
  viewer: "viewer"
}

model StationAndSensors{
  info: WeatherStation,
  sensors: Sensor[]
}

model HistoryRecord{
  value?: float64,
  createdAt: utcDateTime;
}

model SensorHistory{
  sensorName: string,
  unitId: string,
  history: HistoryRecord[]
}

@route("/tokens")
@tag("Token")
@useAuth(BearerAuth)
interface Token {
  /** Generates a new token. Only succeeds if you are authenticated using an admin token, or once using the init token `%12345678%`. */
  @post generate(@query role: TokenRole): string | Error;
}

@route("/stations")
@tag("Station")
@useAuth(BearerAuth)
interface Station {
  /** Get all stations. */
  @get all(): WeatherStation[] | Error;

  /** Get one station and it's sensors. */
  @get one(@path id: int64): StationAndSensors | Error;

  /** Connect to a station's live websocket. */
  @route("/{id}/live")
  @get connect(@path id: int64): {
    @statusCode statusCode: 101;
    @header connection: "Upgrade";
    @header upgrade: "websocket";
  } | Error;

  /** Get the history of one ore more sensors (in a specific interval). */
  @route("/{id}/history")
  @get history(@path id: int64, @query from?: utcDateTime, @query to?: utcDateTime, @query sensors?: string[]): Error | SensorHistory[];
}