# Constructor for objects of type Wiki

Represents a wiki page in Synapse with content specified in markdown.

## Usage

``` r
Wiki(title=NULL, owner=NULL, markdown=NULL, markdownFile=NULL, attachments=NULL, fileHandles=NULL, parentWikiId=NULL)
```

## Arguments

- title:

  optional named parameter: Title of the Wiki  

- owner:

  optional named parameter: Parent entity or ID of the parent entity
  that the Wiki will belong to  

- markdown:

  optional named parameter: Content of the Wiki (cannot be defined if
  markdownFile is defined)  

- markdownFile:

  optional named parameter: Path to file which contains the Content of
  Wiki (cannot be defined if markdown is defined)  

- attachments:

  optional named parameter: List of paths to files to attach  

- fileHandles:

  optional named parameter: List of file handle IDs representing files
  to be attached  

- parentWikiId:

  optional named parameter: (optional) For subpages, specify parent wiki
  page

## Value

An object of type Wiki

## Examples

``` r
if (FALSE) { # \dontrun{
# Create a Wiki
content <- "
# My Wiki Page

Here is a description of my **fantastic** project!

"
wiki <- Wiki(owner = project,
             title = "My Wiki Page",
             markdown = content)
wiki <- synStore(wiki)

# Update a Wiki
wiki <- synGetWiki(project)
wiki.markdown <- "
# My Wiki Page

Here is a description of my **fantastic** project! Let's
*emphasize* the important stuff.

"

wiki <- synStore(wiki)
} # }
```
