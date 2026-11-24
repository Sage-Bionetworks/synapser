# WikiPage : get_markdown_file

Get the markdown URL of this wiki page.

## Usage

``` r
synGetMarkdownFile(instance, download_file=TRUE, download_location=NULL, synapse_client=NULL)
```

## Arguments

- instance:

  (WikiPage) The WikiPage instance to operate on.

- download_file:

  (bool) Whether associated files should be downloaded. Default is TRUE.

- download_location:

  (Optional\[str\]) The directory to download the file to. Required if
  download_file is TRUE.

- synapse_client:

  (Optional\[Synapse\]) Optionally provide a Synapse client.

## Value

If download_file is TRUE, the markdown file will be downloaded to the
download_location. Otherwise, the URL will be returned.

## Errors

An error is raised if owner_id or id is not provided.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Get the markdown URL for a wiki page
    # This example shows how to get the markdown URL for a wiki page.
    markdown_url = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetMarkdownFile(download_file = FALSE)
    cat("Markdown URL:", markdown_url, "\n")

## Example 2: Download the markdown file for a wiki page
    # This example shows how to download the markdown file for a wiki page.
    markdown_file_path = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetMarkdownFile(download_file = TRUE, download_location = "~/temp")
    cat("Markdown file path:", markdown_file_path, "\n")
} # }
```
