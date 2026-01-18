import type { HistoryRecord, Sensor, SensorHistory, StationAndSensors, WeatherStation } from "../models.js";

export function decodeBase64(value: string): Uint8Array | undefined {
  if(!value) {
    return value as any;
  }
  // Normalize Base64URL to Base64
  const base64 = value.replace(/-/g, '+').replace(/_/g, '/')
    .padEnd(value.length + (4 - (value.length % 4)) % 4, '=');

  return new Uint8Array(Buffer.from(base64, 'base64'));
}export function encodeUint8Array(
  value: Uint8Array | undefined | null,
  encoding: BufferEncoding,
): string | undefined {
  if (!value) {
    return value as any;
  }
  return Buffer.from(value).toString(encoding);
}export function dateDeserializer(date?: string | null): Date {
  if (!date) {
    return date as any;
  }

  return new Date(date);
}export function dateRfc7231Deserializer(date?: string | null): Date {
  if (!date) {
    return date as any;
  }

  return new Date(date);
}export function dateRfc3339Serializer(date?: Date | null): string {
  if (!date) {
    return date as any
  }

  return date.toISOString();
}export function dateRfc7231Serializer(date?: Date | null): string {
  if (!date) {
    return date as any;
  }

  return date.toUTCString();
}export function dateUnixTimestampSerializer(date?: Date | null): number {
  if (!date) {
    return date as any;
  }

  return Math.floor(date.getTime() / 1000);
}export function dateUnixTimestampDeserializer(date?: number | null): Date {
  if (!date) {
    return date as any;
  }

  return new Date(date * 1000);
}export function jsonArrayWeatherStationToTransportTransform(
  items_?: Array<WeatherStation> | null,
): any {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonWeatherStationToTransportTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArrayWeatherStationToApplicationTransform(
  items_?: any,
): Array<WeatherStation> {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonWeatherStationToApplicationTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonWeatherStationToTransportTransform(
  input_?: WeatherStation | null,
): any {
  if(!input_) {
    return input_ as any;
  }
    return {
    id: input_.id,name: input_.name,longitude: input_.longitude,latitude: input_.latitude,createdAt: input_.createdAt
  }!;
}export function jsonWeatherStationToApplicationTransform(
  input_?: any,
): WeatherStation {
  if(!input_) {
    return input_ as any;
  }
    return {
    id: input_.id,name: input_.name,longitude: input_.longitude,latitude: input_.latitude,createdAt: input_.createdAt
  }!;
}export function jsonStationAndSensorsToTransportTransform(
  input_?: StationAndSensors | null,
): any {
  if(!input_) {
    return input_ as any;
  }
    return {
    info: jsonWeatherStationToTransportTransform(input_.info),sensors: jsonArraySensorToTransportTransform(input_.sensors)
  }!;
}export function jsonStationAndSensorsToApplicationTransform(
  input_?: any,
): StationAndSensors {
  if(!input_) {
    return input_ as any;
  }
    return {
    info: jsonWeatherStationToApplicationTransform(input_.info),sensors: jsonArraySensorToApplicationTransform(input_.sensors)
  }!;
}export function jsonArraySensorToTransportTransform(
  items_?: Array<Sensor> | null,
): any {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonSensorToTransportTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArraySensorToApplicationTransform(
  items_?: any,
): Array<Sensor> {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonSensorToApplicationTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonSensorToTransportTransform(input_?: Sensor | null): any {
  if(!input_) {
    return input_ as any;
  }
    return {
    id: input_.id,element: input_.element,name: input_.name,recordIntervalSeconds: input_.recordIntervalSeconds,historyIntervalSeconds: input_.historyIntervalSeconds
  }!;
}export function jsonSensorToApplicationTransform(input_?: any): Sensor {
  if(!input_) {
    return input_ as any;
  }
    return {
    id: input_.id,element: input_.element,name: input_.name,recordIntervalSeconds: input_.recordIntervalSeconds,historyIntervalSeconds: input_.historyIntervalSeconds
  }!;
}export function jsonArrayStringToTransportTransform(
  items_?: Array<string> | null,
): any {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = item as any;
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArrayStringToApplicationTransform(
  items_?: any,
): Array<string> {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = item as any;
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArraySensorHistoryToTransportTransform(
  items_?: Array<SensorHistory> | null,
): any {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonSensorHistoryToTransportTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArraySensorHistoryToApplicationTransform(
  items_?: any,
): Array<SensorHistory> {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonSensorHistoryToApplicationTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonSensorHistoryToTransportTransform(
  input_?: SensorHistory | null,
): any {
  if(!input_) {
    return input_ as any;
  }
    return {
    sensorName: input_.sensorName,unitId: input_.unitId,history: jsonArrayHistoryRecordToTransportTransform(input_.history)
  }!;
}export function jsonSensorHistoryToApplicationTransform(
  input_?: any,
): SensorHistory {
  if(!input_) {
    return input_ as any;
  }
    return {
    sensorName: input_.sensorName,unitId: input_.unitId,history: jsonArrayHistoryRecordToApplicationTransform(input_.history)
  }!;
}export function jsonArrayHistoryRecordToTransportTransform(
  items_?: Array<HistoryRecord> | null,
): any {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonHistoryRecordToTransportTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArrayHistoryRecordToApplicationTransform(
  items_?: any,
): Array<HistoryRecord> {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonHistoryRecordToApplicationTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonHistoryRecordToTransportTransform(
  input_?: HistoryRecord | null,
): any {
  if(!input_) {
    return input_ as any;
  }
    return {
    value: input_.value,createdAt: dateRfc3339Serializer(input_.createdAt)
  }!;
}export function jsonHistoryRecordToApplicationTransform(
  input_?: any,
): HistoryRecord {
  if(!input_) {
    return input_ as any;
  }
    return {
    value: input_.value,createdAt: dateDeserializer(input_.createdAt)!
  }!;
}
