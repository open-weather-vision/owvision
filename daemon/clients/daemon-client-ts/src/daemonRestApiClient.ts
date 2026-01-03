import type { BearerTokenCredential } from "@typespec/ts-http-runtime";
import { createDaemonRestApiClientContext, type DaemonRestApiClientContext, type DaemonRestApiClientOptions } from "./api/daemonRestApiClientContext.js";
import { createStationsClientContext, type StationsClientContext, type StationsClientOptions } from "./api/stationsClient/stationsClientContext.js";
import { all, type AllOptions, connect, type ConnectOptions, one, type OneOptions } from "./api/stationsClient/stationsClientOperations.js";
import { createTokensClientContext, type TokensClientContext, type TokensClientOptions } from "./api/tokensClient/tokensClientContext.js";
import { generate, type GenerateOptions } from "./api/tokensClient/tokensClientOperations.js";
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
export class StationsClient {
  #context: StationsClientContext

  constructor(
    endpoint: "http://127.0.0.1:7070/api/v1" | "https://0.0.0.0:8080/api/v1" | string,
    credential: BearerTokenCredential,
    options?: StationsClientOptions,
  ) {
    this.#context = createStationsClientContext(endpoint, credential, options);

  }
  async all(options?: AllOptions) {
    return all(this.#context, options);
  };
  async one(id: bigint, options?: OneOptions) {
    return one(this.#context, id, options);
  };
  async connect(id: bigint, options?: ConnectOptions) {
    return connect(this.#context, id, options);
  }
}
export class TokensClient {
  #context: TokensClientContext

  constructor(
    endpoint: "http://127.0.0.1:7070/api/v1" | "https://0.0.0.0:8080/api/v1" | string,
    credential: BearerTokenCredential,
    options?: TokensClientOptions,
  ) {
    this.#context = createTokensClientContext(endpoint, credential, options);

  }
  async generate(role: TokenRole, options?: GenerateOptions) {
    return generate(this.#context, role, options);
  }
}
