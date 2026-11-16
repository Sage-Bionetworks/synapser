# WikiOrderHint

A WikiOrderHint contains the order hint for the root wiki that
corresponds to the given owner ID and type.

## Usage

``` r
WikiOrderHint(owner_id=NULL, owner_object_type=NULL, id_list=list(), etag=NULL)
```

## Format

An S3-style class object.

## Arguments

- owner_id:

  (Optional\[str\]) The Synapse ID of the owner object (e.g., entity,
  evaluation, etc.).

- owner_object_type:

  (Optional\[str\]) The type of the owner object.

- id_list:

  (list\[str\]) The list of sub wiki ids that in the order that they
  should be placed relative to their siblings.

- etag:

  (Optional\[str\]) The etag of this object.

## Value

NULL

## Methods

- `WikiOrderHint(owner_id=NULL, owner_object_type=NULL, id_list=list(), etag=NULL)`:
  Constructor for `WikiOrderHint`

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Get the WikiOrderHint for a project
    # This example shows how to get a WikiOrderHint for existing wiki pages in a project.
    library(synapser)
    synLogin()

    project = Project(name = "My uniquely named project about Alzheimer's Disease") |> synGet()
    wiki_order_hint = WikiOrderHint(owner_id = project$id) |> synGet()
    print(wiki_order_hint)

## Example 2: Set the WikiOrderHint for a project
    # This example shows how to set a WikiOrderHint for existing wiki pages in a project.
    # The WikiOrderHint is not set by default, so you need to set it explicitly.
    # root_wiki_page and wiki_page_1 to wiki_page_4 are WikiPage objects that
    # already exist in the project.
    wiki_order_hint = WikiOrderHint(owner_id = project$id) |> synGet()

    wiki_order_hint$id_list = list(
        root_wiki_page$id,
        wiki_page_1$id,
        wiki_page_3$id,
        wiki_page_2$id,
        wiki_page_4$id
    )
    wiki_order_hint = wiki_order_hint |> synStore()
    print(wiki_order_hint)

## Example 3: Update the WikiOrderHint for a project
    # This example shows how to update a WikiOrderHint for existing wiki pages in a project.
    wiki_order_hint$id_list = list(
        root_wiki_page$id,
        wiki_page_1$id,
        wiki_page_2$id,
        wiki_page_3$id,
        wiki_page_4$id
    )
    wiki_order_hint = wiki_order_hint |> synStore()
    print(wiki_order_hint)
} # }
```
