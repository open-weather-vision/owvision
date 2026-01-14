import { parse } from "uri-template";
import { StationsClientContext } from "./stationsClientContext.js";
import { createRestError } from "../../helpers/error.js";
import type { OperationOptions } from "../../helpers/interfaces.js";
import { jsonArrayStationToApplicationTransform, jsonStationAndSensorsToApplicationTransform } from "../../models/internal/serializers.js";
import type { Station, StationAndSensors } from "../../models/models.js";

export interface AllOptions extends OperationOptions {

}
/**
 * Get all stations.
 *
 * @param {StationsClientContext} client
 * @param {AllOptions} [options]
 */
export async function all(
  client: StationsClientContext,
  options?: AllOptions,
): Promise<Array<Station>> {
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
    return jsonArrayStationToApplicationTransform(response.body)!;
  }
  throw createRestError(response);
}
;
export interface OneOptions extends OperationOptions {

}
/**
 * Get one station and it's sensors.
 *
 * @param {StationsClientContext} client
 * @param {bigint} id
 * @param {OneOptions} [options]
 */
export async function one(
  client: StationsClientContext,
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
 * @param {StationsClientContext} client
 * @param {bigint} id
 * @param {ConnectOptions} [options]
 */
export async function connect(
  client: StationsClientContext,
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
