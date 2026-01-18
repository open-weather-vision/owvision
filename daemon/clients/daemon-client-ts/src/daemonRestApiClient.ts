import type { BearerTokenCredential } from "@typespec/ts-http-runtime";
import { createDaemonRestApiClientContext, type DaemonRestApiClientContext, type DaemonRestApiClientOptions } from "./api/daemonRestApiClientContext.js";
import { createStationClientContext, type StationClientContext, type StationClientOptions } from "./api/stationClient/stationClientContext.js";
import { all, type AllOptions, connect, type ConnectOptions, history, type HistoryOptions, one, type OneOptions } from "./api/stationClient/stationClientOperations.js";
import { createTokenClientContext, type TokenClientContext, type TokenClientOptions } from "./api/tokenClient/tokenClientContext.js";
import { generate, type GenerateOptions } from "./api/tokenClient/tokenClientOperations.js";
import type { TokenRole } from "./models/models.js";

export class DaemonRestApiClient {
  #context: DaemonRestApiClientContext
  ;

  constructor(
    endpoint: "http://127.0.0.1:7070/api/v1" | "https://0.0.0.0:8080/api/v1" | string,
    credential: BearerTokenCredential,
    options?: DaemonRestApiClientOptions,
  ) {
    this.#context = createDaemonRestApiClientContext(
      endpoint,
      credential,
      options
    );

  }

}
export class StationClient {
  #context: StationClientContext

  constructor(
    endpoint: "http://127.0.0.1:7070/api/v1" | "https://0.0.0.0:8080/api/v1" | string,
    credential: BearerTokenCredential,
    options?: StationClientOptions,
  ) {
    this.#context = createStationClientContext(endpoint, credential, options);

  }
  async all(options?: AllOptions) {
    return all(this.#context, options);
  };
  async one(id: bigint, options?: OneOptions) {
    return one(this.#context, id, options);
  };
  async connect(id: bigint, options?: ConnectOptions) {
    return connect(this.#context, id, options);
  };
  async history(id: bigint, options?: HistoryOptions) {
    return history(this.#context, id, options);
  }
}
export class TokenClient {
  #context: TokenClientContext

  constructor(
    endpoint: "http://127.0.0.1:7070/api/v1" | "https://0.0.0.0:8080/api/v1" | string,
    credential: BearerTokenCredential,
    options?: TokenClientOptions,
  ) {
    this.#context = createTokenClientContext(endpoint, credential, options);

  }
  async generate(role: TokenRole, options?: GenerateOptions) {
    return generate(this.#context, role, options);
  }
}
