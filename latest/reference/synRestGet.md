# synRestGet

Sends an HTTP GET request to the Synapse server.

## Usage

``` r
synRestGet(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
```

## Arguments

- uri:

  (str) URI on which get is performed

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

  (AsyncClient) The async client to use when making this specific call.

- kwargs:

  optional named parameter: Any other arguments taken by a
  [request](https://www.python-httpx.org/api/) method

## Value

JSON encoding of response

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    library(synapser)
    synLogin()

    # Low-level REST access to an entity's raw JSON, bypassing the synGet() model wrapper
    response = synRestGet(uri = "/entity/syn123456")
    response
} # }
```
