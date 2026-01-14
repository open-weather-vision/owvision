import type { Sensor, Station, StationAndSensors } from "../models.js";

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
}export function jsonArrayStationToTransportTransform(
  items_?: Array<Station> | null,
): any {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonStationToTransportTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonArrayStationToApplicationTransform(
  items_?: any,
): Array<Station> {
  if(!items_) {
    return items_ as any;
  }
  const _transformedArray = [];

  for (const item of items_ ?? []) {
    const transformedItem = jsonStationToApplicationTransform(item as any);
    _transformedArray.push(transformedItem);
  }

  return _transformedArray as any;
}export function jsonStationToTransportTransform(input_?: Station | null): any {
  if(!input_) {
    return input_ as any;
  }
    return {
    id: input_.id,name: input_.name,longitude: input_.longitude,latitude: input_.latitude,createdAt: input_.createdAt
  }!;
}export function jsonStationToApplicationTransform(input_?: any): Station {
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
    station: jsonStationToTransportTransform(input_.station),sensors: jsonArraySensorToTransportTransform(input_.sensors)
  }!;
}export function jsonStationAndSensorsToApplicationTransform(
  input_?: any,
): StationAndSensors {
  if(!input_) {
    return input_ as any;
  }
    return {
    station: jsonStationToApplicationTransform(input_.station),sensors: jsonArraySensorToApplicationTransform(input_.sensors)
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
    id: input_.id,element: input_.element,name: input_.name
  }!;
}export function jsonSensorToApplicationTransform(input_?: any): Sensor {
  if(!input_) {
    return input_ as any;
  }
    return {
    id: input_.id,element: input_.element,name: input_.name
  }!;
}
