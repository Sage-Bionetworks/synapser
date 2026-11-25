# UsedURL

URL that was used or executed by an Activity such as a link to a GitHub
commit or a link to a specific version of a software tool.

## Usage

``` r
UsedURL(name=NULL, url=NULL)
```

## Format

An S3-style class object.

## Arguments

- name:

  (Optional\[str\]) The name of the URL.

- url:

  (Optional\[str\]) The external URL of the file that was used such as a
  link to a GitHub commit or a link to a specific version of a software
  tool.

## Value

NULL

## Methods

- `UsedURL(name=NULL, url=NULL)`: Constructor for `UsedURL`

## Examples

``` r
if (FALSE) { # \dontrun{
## Recording a URL used to produce a file
    library(synapser)
    synLogin()

    activity = Activity(
        name = "Analysis",
        used = list(UsedURL(name = "Reference genome", url = "https://www.ncbi.nlm.nih.gov/grc/human")),
        executed = list(UsedURL(name = "Analysis code", url = "https://github.com/my-org/my-analysis"))
    )
    activity = activity |> synStore(parent = "syn123")
} # }
```
