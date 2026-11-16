# synRestPost

Sends an HTTP POST request to the Synapse server.

## Usage

``` r
synRestPost(uri, body=NULL, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
```

## Arguments

- uri:

  (str) URI on which the request is performed

- body:

  (Any) The payload to be delivered, as a JSON-encoded string (e.g. via
  [`rjson::toJSON()`](https://rdrr.io/pkg/rjson/man/toJSON.html)). This
  is passed straight through to the underlying HTTP client's `content`
  argument, which only accepts a string or raw bytes – passing a named
  list/dict directly will fail with
  `TypeError: Unexpected type for 'content'`.

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
    # For ordinary entity creation, prefer the higher-level constructors
    # and synStore() instead -- e.g. Folder(...) |> synStore(). Reach for
    # synRestPost() only for REST endpoints that don't have a higher-level
    # model wrapper.
    library(synapser)
    synLogin()

    new_folder_properties = list(
        name = "My New Folder",
        parentId = "syn123456",
        concreteType = "org.sagebionetworks.repo.model.Folder"
    )
    response = synRestPost(uri = "/entity", body = rjson::toJSON(new_folder_properties))
    response
} # }
```
