# WikiPage : get_attachment_handles

Get the file handles of all attachments on this wiki page.

## Usage

``` r
synGetAttachmentHandles(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (WikiPage) The WikiPage instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) Optionally provide a Synapse client.

## Value

The list of FileHandles for all file attachments of this WikiPage.

## Errors

An error is raised if owner_id or id is not provided.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the file handles of all attachments on a wiki page
    # This example shows how to get the file handles of all attachments on a wiki page.
    attachment_handles = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetAttachmentHandles()
    cat("Attachment handles:\n")
    attachment_handles$list
} # }
```
