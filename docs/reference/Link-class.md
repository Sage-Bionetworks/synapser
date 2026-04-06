# Link

Represents a link in Synapse.

Links must have a target ID and a parent. When you do synGet on a Link
object, the Link object is returned. If the target is desired, specify
followLink=TRUE in synapseclient.Synapse.get.

## Format

An R6 class object.

## Methods

- `Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL)`:
  Constructor for [`Link`](https://r-docs.synapse.org/reference/Link.md)
