# WikiHistorySnapshot

A WikiHistorySnapshot contains basic information about an update to a
WikiPage.

## Usage

``` r
WikiHistorySnapshot(version=NULL, modified_on=NULL, modified_by=NULL)
```

## Format

An S3-style class object.

## Arguments

- version:

  (Optional\[str\]) The version number of the wiki page.

- modified_on:

  (Optional\[str\]) The timestamp when this version was created.

- modified_by:

  (Optional\[str\]) The ID of the user that created this version.

## Value

NULL

## Methods

- `WikiHistorySnapshot(version=NULL, modified_on=NULL, modified_by=NULL)`:
  Constructor for `WikiHistorySnapshot`

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the history of a wiki page
    library(synapser)
    synLogin()

    project = Project(name = "My uniquely named project about Alzheimer's Disease") |> synGet()
    wiki_page_id = "123456"  # Replace with the ID of a wiki page in the project
    for (history in as.list(WikiHistorySnapshot() |> synGet(owner_id = project$id, id = wiki_page_id))) {
        print(history)
    }
} # }
```
