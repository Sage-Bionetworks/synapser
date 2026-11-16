# synRestDelete

Sends an HTTP DELETE request to the Synapse server.

## Usage

``` r
synRestDelete(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
```

## Arguments

- uri:

  (str) URI of resource to be deleted

- endpoint:

  (str) Server endpoint, defaults to the client's configured repository
  endpoint (see
  [`synSetEndpoints()`](https://r-docs.synapse.org/latest/reference/synSetEndpoints.md)).

- headers:

  (Headers) Named list of headers to use.

- retry_policy:

  (dict\[str, Any\]) A retry policy (named list) whose keys should match
  the parameters of
  [with_retry_time_based_async](https://python-docs.synapse.org/reference/core/),
  the underlying Python client's retry mechanism.

- requests_session_async_synapse:

  (AsyncClient) The async client to use when making this specific call

- kwargs:

  optional named parameter: Any other arguments taken by a
  [request](https://www.python-httpx.org/api/) method

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # For ordinary entity deletion, prefer the higher-level synDelete()
    # function instead -- e.g. synDelete("syn123456"). Reach for
    # synRestDelete() only for REST endpoints that don't have a
    # higher-level model wrapper.
    library(synapser)
    synLogin()

    synRestDelete(uri = "/entity/syn123456")
} # }
```
