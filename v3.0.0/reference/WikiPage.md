# WikiPage

Represents a [Wiki
Page](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/v2/wiki/V2WikiPage.html).

## Usage

``` r
WikiPage(id=NULL, etag=NULL, title=NULL, parent_id=NULL, markdown=NULL, attachments=list(), owner_id=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, wiki_version=NULL, markdown_file_handle_id=NULL, attachment_file_handle_ids=list())
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique identifier for this wiki page.

- etag:

  (Optional\[str\]) The etag of this object. Synapse employs an
  Optimistic Concurrency Control (OCC) scheme to handle concurrent
  updates. Since the E-Tag changes every time an entity is updated it is
  used to detect when a client's current representation of an entity is
  out-of-date.

- title:

  (Optional\[str\]) The title of this page.

- parent_id:

  (Optional\[str\]) When set, the WikiPage is a sub-page of the
  indicated parent WikiPage.

- markdown:

  (Optional\[str\]) The markdown content of the wiki page.

- attachments:

  (list\[dict\[str, Any\]\]) A list of file attachments associated with
  the wiki page.

- owner_id:

  (Optional\[str\]) The Synapse ID of the owning object (e.g., entity,
  evaluation, etc.).

- created_on:

  (Optional\[str\]) The timestamp when this page was created.

- created_by:

  (Optional\[str\]) The ID of the user that created this page.

- modified_on:

  (Optional\[str\]) The timestamp when this page was last modified.

- modified_by:

  (Optional\[str\]) The ID of the user that last modified this page.

- wiki_version:

  (Optional\[str\]) The version number of this wiki page.

- markdown_file_handle_id:

  (Optional\[str\]) The ID of the file handle containing the markdown
  content.

- attachment_file_handle_ids:

  (list\[str\]) The list of attachment file handle ids of this page.

## Value

NULL

## Methods

- `WikiPage(id=NULL, etag=NULL, title=NULL, parent_id=NULL, markdown=NULL, attachments=list(), owner_id=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, wiki_version=NULL, markdown_file_handle_id=NULL, attachment_file_handle_ids=list())`:
  Constructor for `WikiPage`

- [`synCopy`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_Copy.md)`(instance, destination_owner_id, destination_sub_page_id=NULL, update_links=TRUE, entity_map=NULL, synapse_client=NULL)`:
  Copy the wiki page tree of the owner entity to another entity and
  update internal links.

  If id is set on this WikiPage, only the sub-tree rooted at that wiki
  page is copied. Otherwise the entire wiki of the owner entity is
  copied.

- [`synGetAttachment`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_GetAttachment.md)`(instance, file_name, download_file=TRUE, download_location=NULL, synapse_client=NULL)`:
  Download the wiki page attachment to a local file or return the URL.

- [`synGetAttachmentHandles`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_GetAttachmentHandles.md)`(instance, synapse_client=NULL)`:
  Get the file handles of all attachments on this wiki page.

- [`synGetAttachmentPreview`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_GetAttachmentPreview.md)`(instance, file_name, download_file=TRUE, download_location=NULL, synapse_client=NULL)`:
  Download the wiki page attachment preview to a local file or return
  the URL.

- [`synGetMarkdownFile`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_GetMarkdownFile.md)`(instance, download_file=TRUE, download_location=NULL, synapse_client=NULL)`:
  Get the markdown URL of this wiki page.

- [`synReformatAttachmentFileName`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_ReformatAttachmentFileName.md)`(attachment_file_name)`:
  Reformat the attachment file name to be a valid attachment path.

- [`synRestore`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_Restore.md)`(instance, synapse_client=NULL)`:
  Restore a specific version of a wiki page.

- [`synUnzipGzippedFile`](https://r-docs.synapse.org/v3.0.0/reference/WikiPage_UnzipGzippedFile.md)`(file_path)`:
  Unzip the gzipped file and return the file path to the unzipped file.
  If the file is a markdown file, the content will be printed.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Store a wiki page
    # This example shows how to store a wiki page.
    library(synapser)
    synLogin()

    project = Project(name = "My uniquely named project about Alzheimer's Disease") |> synGet()
    wiki_page = WikiPage(owner_id = project$id, title = "My wiki page") |> synStore()
    print(wiki_page)

## Example 2: Get a wiki page from Synapse
    # This example shows how to get a wiki page from Synapse.
    # It uses the project and wiki_page from Example 1.
    wiki_page = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGet()
    print(wiki_page)

## Example 3: Delete a wiki page
    # This example shows how to delete a wiki page.
    # It uses the project and wiki_page from Example 1.
    WikiPage(owner_id = project$id, id = wiki_page$id) |> synDelete()
    print("Wiki page deleted successfully.")
} # }
```
