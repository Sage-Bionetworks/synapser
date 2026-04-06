# synGetWiki

Get a Wiki object from Synapse. Uses wiki2 API which supports
versioning.

## Usage

``` r
synGetWiki(owner, subpageId=NULL, version=NULL)
```

## Arguments

- owner:

  The entity to which the Wiki is attached  

- subpageId:

  The id of the specific sub-page or NULL to get the root Wiki page  

- version:

  The version of the page to retrieve or NULL to retrieve the latest

## Value

a Wiki object

## Examples

``` r
if (FALSE) { # \dontrun{
wiki <- synGetWiki(project)
} # }
```
