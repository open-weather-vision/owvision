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
  v1: "0.0.3"
}

model Station {
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
}

enum SensorElement{
  precipationAccumulated,
  precipationRate,
  snowHeight,
  pressure,
  temperature,
  windSpeed,
  windDirection,
  humidity
}

@error
model Error {
  code: ErrorCode;
  message: string;
}

enum ErrorCode{
  unauthorized: "unauthorized",
  notFound: "notFound"
}

enum TokenRole{
  admin: "admin",
  recorder: "recorder",
  viewer: "viewer"
}

model StationAndSensors{
  station: Station,
  sensors: Sensor[]
}

@route("/tokens")
@tag("Token")
@useAuth(BearerAuth)
interface Tokens {
  /** Generates a new token. Only succeeds if you are authenticated using an admin token, or once using the init token `%12345678%`. */
  @post generate(@query role: TokenRole): string | Error;
}

@route("/stations")
@tag("Station")
@useAuth(BearerAuth)
interface Stations {
  /** Get all stations. */
  @get all(): Station[] | Error;

  /** Get one station and it's sensors. */
  @get one(@path id: int64): StationAndSensors | Error;

  /** Connect to a station's live websocket. */
  @route("/{id}/live")
  @get connect(@path id: int64): {
    @statusCode statusCode: 101;
    @header connection: "Upgrade";
    @header upgrade: "websocket";
  } | Error;
}
