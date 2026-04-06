# Wiki

Represents a wiki page in Synapse with content specified in markdown.

## Format

An R6 class object.

## Methods

- `Wiki(title=NULL, owner=NULL, markdown=NULL, markdownFile=NULL, attachments=NULL, fileHandles=NULL, parentWikiId=NULL)`:
  Constructor for [`Wiki`](https://r-docs.synapse.org/reference/Wiki.md)

- `json()`: Returns the JSON representation of the Wiki object.

- `update_markdown(markdown=NULL, markdown_file=NULL)`: Updates the
  wiki's markdown. Specify only one of markdown or markdown_file
