using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/accounts")
@tag("Accounts")
interface Accounts {
  @post @operationId("createAccount") @summary("Create account")
  create(@body body: AccountCreateRequest): {
    @statusCode _: 201;
    @body body: AccountCreateResponse;
  };

  @put @operationId("updateAccount") @summary("Update account")
  update(@query id: string, @body body: AccountUpdateRequest): AccountUpdateResponse;

  @get @operationId("listOrGetAccounts") @summary("List accounts or get by ID")
  @doc("Returns a single account if ?id= is provided, or a list of all accounts. Supports tag filtering via ?tag.key=value.")
  list(@query id?: string): Account | AccountListResponse;

  @delete @operationId("deleteAccount") @summary("Delete account")
  delete(@query id: string): AccountDeleteResponse;
}
