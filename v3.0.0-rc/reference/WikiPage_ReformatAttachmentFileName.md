# WikiPage : reformat_attachment_file_name

Reformat the attachment file name to be a valid attachment path.

## Usage

``` r
synReformatAttachmentFileName(attachment_file_name)
```

## Arguments

- attachment_file_name:

  (str) The name of the attachment file.

## Value

The reformatted attachment file name.

## Examples

``` r
if (FALSE) { # \dontrun{
## Reformat the attachment file name
    attachment_file_name = "file.txt"
    attachment_file_name_reformatted = synReformatAttachmentFileName(attachment_file_name)
    cat("Reformatted attachment file name:", attachment_file_name_reformatted, "\n")
} # }
```
