import { parse } from "uri-template";
import { TokenClientContext } from "./tokenClientContext.js";
import { createRestError } from "../../helpers/error.js";
import type { OperationOptions } from "../../helpers/interfaces.js";
import { TokenRole } from "../../models/models.js";

export interface GenerateOptions extends OperationOptions {

}
/**
 * Generates a new token. Only succeeds if you are authenticated using an admin
 * token, or once using the init token `%12345678%`.
 *
 * @param {TokenClientContext} client
 * @param {TokenRole} role
 * @param {GenerateOptions} [options]
 */
export async function generate(
  client: TokenClientContext,
  role: TokenRole,
  options?: GenerateOptions,
): Promise<string> {
  const path = parse("/tokens{?role}").expand({
    role: role
  });
  const httpRequestOptions = {
    headers: {

    },
  };
  const response = await client.pathUnchecked(path).post(httpRequestOptions);

  ;
  if (typeof options?.operationOptions?.onResponse === "function") {
    options?.operationOptions?.onResponse(response);
  }
  if (+response.status === 200 && response.headers["content-type"]?.includes("application/json")) {
    return response.body!;
  }
  throw createRestError(response);
}
;
