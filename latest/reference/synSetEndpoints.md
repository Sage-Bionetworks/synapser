# synSetEndpoints

Sets the locations for each of the Synapse services (mostly useful for
testing).

## Usage

``` r
synSetEndpoints(repoEndpoint=NULL, authEndpoint=NULL, fileHandleEndpoint=NULL, portalEndpoint=NULL, skip_checks=FALSE)
```

## Arguments

- repoEndpoint:

  (str) Location of synapse repository

- authEndpoint:

  (str) Location of authentication service

- fileHandleEndpoint:

  (str) Location of file service

- portalEndpoint:

  (str) Location of the website

- skip_checks:

  (bool) Skip version and endpoint checks

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Switching endpoints
    # To switch between staging and production endpoints
    library(synapser)

    synSetEndpoints(
        repoEndpoint = "https://repo-staging.prod.sagebase.org/repo/v1",
        authEndpoint = "https://auth-staging.prod.sagebase.org/auth/v1",
        fileHandleEndpoint = "https://file-staging.prod.sagebase.org/file/v1",
        portalEndpoint = "https://staging.synapse.org/"
    )

    synSetEndpoints(
        repoEndpoint = "https://repo-prod.prod.sagebase.org/repo/v1",
        authEndpoint = "https://auth-prod.prod.sagebase.org/auth/v1",
        fileHandleEndpoint = "https://file-prod.prod.sagebase.org/file/v1",
        portalEndpoint = "https://www.synapse.org/"
    )
} # }
```
