# synRestGET

Sends an HTTP GET request to the Synapse server.

## Usage

``` r
synRestGET(uri, endpoint=NULL, headers=NULL, retryPolicy=list(), ...)
```

## Arguments

- uri:

  URI on which get is performed  

- endpoint:

  Server endpoint. The required endpoint is shown in each service's page
  in the REST API documentation (http://docs.synapse.org/rest). Options
  are: 'https://repo-prod.prod.sagebase.org/repo/v1' (the default),
  'https://file-prod.prod.sagebase.org/file/v1' or
  'https://file-prod.prod.sagebase.org/auth/v1'.  

- headers:

  named list of headers to use rather than the API-key-signed default
  set of headers  

- retryPolicy:

- ...:

  Any other arguments taken by a <http://docs.python-requests.org>
  method

## Value

JSON encoding of response
