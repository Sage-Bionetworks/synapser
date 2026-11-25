# synDownloadListClear

Clear all files from the Synapse download list (cart).

## Usage

``` r
synDownloadListClear(synapse_client=NULL)
```

## Arguments

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Clear the download list
    # Remove all files from the cart.
    library(synapser)
    synLogin()

    synDownloadListClear()
} # }
```
