import { parse } from "uri-template";
import { StationClientContext } from "./stationClientContext.js";
import { createRestError } from "../../helpers/error.js";
import type { OperationOptions } from "../../helpers/interfaces.js";
import { dateRfc3339Serializer, jsonArraySensorHistoryToApplicationTransform, jsonArrayStringToTransportTransform, jsonArrayWeatherStationToApplicationTransform, jsonStationAndSensorsToApplicationTransform } from "../../models/internal/serializers.js";
import type { SensorHistory, StationAndSensors, WeatherStation } from "../../models/models.js";

export interface AllOptions extends OperationOptions {

}
/**
 * Get all stations.
 *
 * @param {StationClientContext} client
 * @param {AllOptions} [options]
 */
export async function all(
  client: StationClientContext,
  options?: AllOptions,
): Promise<Array<WeatherStation>> {
  const path = parse("/stations").expand({

  });
  const httpRequestOptions = {
    headers: {

    },
  };
  const response = await client.pathUnchecked(path).get(httpRequestOptions);

  ;
  if (typeof options?.operationOptions?.onResponse === "function") {
    options?.operationOptions?.onResponse(response);
  }
  if (+response.status === 200 && response.headers["content-type"]?.includes("application/json")) {
    return jsonArrayWeatherStationToApplicationTransform(response.body)!;
  }
  throw createRestError(response);
}
;
export interface OneOptions extends OperationOptions {

}
/**
 * Get one station and it's sensors.
 *
 * @param {StationClientContext} client
 * @param {bigint} id
 * @param {OneOptions} [options]
 */
export async function one(
  client: StationClientContext,
  id: bigint,
  options?: OneOptions,
): Promise<StationAndSensors> {
  const path = parse("/stations/{id}").expand({
    id: id
  });
  const httpRequestOptions = {
    headers: {

    },
  };
  const response = await client.pathUnchecked(path).get(httpRequestOptions);

  ;
  if (typeof options?.operationOptions?.onResponse === "function") {
    options?.operationOptions?.onResponse(response);
  }
  if (+response.status === 200 && response.headers["content-type"]?.includes("application/json")) {
    return jsonStationAndSensorsToApplicationTransform(response.body)!;
  }
  throw createRestError(response);
}
;
export interface ConnectOptions extends OperationOptions {

}
/**
 * Connect to a station's live websocket.
 *
 * @param {StationClientContext} client
 * @param {bigint} id
 * @param {ConnectOptions} [options]
 */
export async function connect(
  client: StationClientContext,
  id: bigint,
  options?: ConnectOptions,
): Promise<void> {
  const path = parse("/stations/{id}/live").expand({
    id: id
  });
  const httpRequestOptions = {
    headers: {

    },
  };
  const response = await client.pathUnchecked(path).get(httpRequestOptions);

  ;
  if (typeof options?.operationOptions?.onResponse === "function") {
    options?.operationOptions?.onResponse(response);
  }
  if (+response.status === 101 && !response.body) {
    return;
  }
  throw createRestError(response);
}
;
export interface HistoryOptions extends OperationOptions {
  from?: Date
  to?: Date
  sensors?: Array<string>
}
/**
 * Get the history of one ore more sensors (in a specific interval).
 *
 * @param {StationClientContext} client
 * @param {bigint} id
 * @param {HistoryOptions} [options]
 */
export async function history(
  client: StationClientContext,
  id: bigint,
  options?: HistoryOptions,
): Promise<Array<SensorHistory>> {
  const path = parse("/stations/{id}/history{?from,to,sensors}").expand({
    id: id,
    ...(options?.from && {from: dateRfc3339Serializer(options.from)}),
    ...(options?.to && {to: dateRfc3339Serializer(options.to)}),
    ...(options?.sensors && {sensors: jsonArrayStringToTransportTransform(options.sensors)})
  });
  const httpRequestOptions = {
    headers: {

    },
  };
  const response = await client.pathUnchecked(path).get(httpRequestOptions);

  ;
  if (typeof options?.operationOptions?.onResponse === "function") {
    options?.operationOptions?.onResponse(response);
  }
  if (+response.status === 200 && response.headers["content-type"]?.includes("application/json")) {
    return jsonArraySensorHistoryToApplicationTransform(response.body)!;
  }
  throw createRestError(response);
}
;
