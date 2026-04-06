# synGetWikiAttachments

Retrieve the attachments to a wiki page.

## Usage

``` r
synGetWikiAttachments(wiki)
```

## Arguments

- wiki:

  the Wiki object for which the attachments are to be returned.

## Value

A list of file handles for the files attached to the Wiki.

## Examples

``` r
if (FALSE) { # \dontrun{
wiki <- synGetWiki(project)
attachments <- synGetWikiAttachments(wiki)
} # }
```
