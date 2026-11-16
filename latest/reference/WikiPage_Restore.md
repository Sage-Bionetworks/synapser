# WikiPage : restore

Restore a specific version of a wiki page.

## Usage

``` r
synRestore(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (WikiPage) The WikiPage instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The restored wiki page.

## Examples

``` r
if (FALSE) { # \dontrun{
## Restore a specific version of a wiki page
    # This example shows how to restore a specific version of a wiki page.
    wiki_page_restored = WikiPage(owner_id = project$id, id = wiki_page$id, wiki_version = "0") |> synRestore()
    wiki_page_restored
} # }
```
