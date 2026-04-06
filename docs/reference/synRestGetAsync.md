# synRestGetAsync

Sends an HTTP GET request to the Synapse server.

## Usage

``` r
synRestGetAsync(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL)
```

## Arguments

- uri:

  URI on which get is performed

- endpoint:

  Server endpoint. Defaults to repoEndpoint

- headers:

  Dictionary of headers to use

- retry_policy:

  A retry policy that matches the arguments of
  [synapseclient.core.retry.with_retry_time_based_async](https://github.com/Sage-Bionetworks/synapsePythonClient/blob/0310ba9ad39a599b9d2240028a79792b05f45ee1/synapseclient/core/retry.py#L262).

- requests_session_async_synapse:

  The async client to use when making this specific call.

- ...:

  Any other arguments taken by a
  [request](https://www.python-httpx.org/api/) method

## Value

JSON encoding of response

## Examples

``` r
if (FALSE) { # \dontrun{
# a helper function to run async function
run_coroutine <- function(coroutine) {
    asyncio <- import("asyncio")
    result <- asyncio$run(coroutine)
    return(result)
    }
# run the coroutine
result <- run_coroutine(synRestGetAsync(uri="/entity/entity_id"))
} # }
```
