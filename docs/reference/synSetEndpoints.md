# synSetEndpoints

Sets the locations for each of the Synapse services (mostly useful for
testing).

## Usage

``` r
synSetEndpoints(repoEndpoint=NULL, authEndpoint=NULL, fileHandleEndpoint=NULL, portalEndpoint=NULL, skip_checks=FALSE)
```

## Arguments

- repoEndpoint:

  Location of synapse repository  

- authEndpoint:

  Location of authentication service  

- fileHandleEndpoint:

  Location of file service  

- portalEndpoint:

  Location of the website  

- skip_checks:

  Skip version and endpoint checks
