/**
 * A sequence of textual characters.
 */
export type String = string;
export enum TokenRole {
  Admin = "admin",
  Recorder = "recorder",
  Viewer = "viewer"
}

export interface WeatherStation {
  id: bigint;
  name: string;
  longitude: number;
  latitude: number;
  createdAt: string;
}
/**
 * A 64-bit integer. (`-9,223,372,036,854,775,808` to `9,223,372,036,854,775,807`)
 */
export type Int64 = bigint;
/**
 * A whole number. This represent any `integer` value possible.
 * It is commonly represented as `BigInteger` in some languages.
 */
export type Integer = number;
/**
 * A numeric type
 */
export type Numeric = number;
/**
 * A 64 bit floating point number. (`±5.0 × 10^−324` to `±1.7 × 10^308`)
 */
export type Float64 = number;
/**
 * A number with decimal value
 */
export type Float = number;
export interface StationAndSensors {
  info: WeatherStation;
  sensors: Array<Sensor>;
}

export interface Sensor {
  id: bigint;
  element: SensorElement;
  name: string;
  recordIntervalSeconds: bigint;
  historyIntervalSeconds: bigint;
}
export enum SensorElement {
  PrecipationAccumulated = "precipationAccumulated",
  PrecipationRate = "precipationRate",
  SnowHeight = "snowHeight",
  Pressure = "pressure",
  Temperature = "temperature",
  WindSpeed = "windSpeed",
  WindDirection = "windDirection",
  Humidity = "humidity",
  WeatherCode = "weatherCode"
}
/**
 * An instant in coordinated universal time (UTC)"
 */
export type UtcDateTime = Date;


export interface SensorHistory {
  sensorName: string;
  unitId: string;
  history: Array<HistoryRecord>;
}

export interface HistoryRecord {
  value?: number;
  createdAt: Date;
}
