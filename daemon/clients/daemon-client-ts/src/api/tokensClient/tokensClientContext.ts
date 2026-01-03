import { type BearerTokenCredential, type Client, type ClientOptions, getClient } from "@typespec/ts-http-runtime";

export interface TokensClientContext extends Client {

}export interface TokensClientOptions extends ClientOptions {
  endpoint?: string;
}export function createTokensClientContext(
  endpoint: "http://127.0.0.1:7070/api/v1" | "https://0.0.0.0:8080/api/v1" | string,
  credential: BearerTokenCredential,
  options?: TokensClientOptions,
): TokensClientContext {
  const params: Record<string, any> = {

  };
  const resolvedEndpoint = "http://127.0.0.1:7070/api/v1".replace(/{([^}]+)}/g, (_, key) =>
    key in params ? String(params[key]) : (() => { throw new Error(`Missing parameter: ${key}`); })()
  );;return getClient(resolvedEndpoint,{
    ...options,credential,authSchemes: [{
      kind: "http",
      scheme: "bearer"
    }]
  })
}
