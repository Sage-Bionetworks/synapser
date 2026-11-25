# WikiHeader

A WikiHeader contains basic metadata about a WikiPage.

## Usage

``` r
WikiHeader(id=NULL, title=NULL, parent_id=NULL)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique identifier for this wiki page.

- title:

  (Optional\[str\]) The title of this page.

- parent_id:

  (Optional\[str\]) When set, the WikiPage is a sub-page of the
  indicated parent WikiPage.

## Value

NULL

## Methods

- `WikiHeader(id=NULL, title=NULL, parent_id=NULL)`: Constructor for
  `WikiHeader`

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the header tree (hierarchy) of wiki pages for an entity
    library(synapser)
    synLogin()

    project = Project(name = "My uniquely named project about Alzheimer's Disease") |> synGet()
    for (header in as.list(WikiHeader() |> synGet(owner_id = project$id))) {
        print(header)
    }
} # }
```
