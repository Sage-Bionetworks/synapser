# File

Represents a file in Synapse.

When a File object is stored, the associated local file or its URL will
be stored in Synapse. A File must have a path (or URL) and a parent.

## Format

An R6 class object.

## Methods

- `File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, name=NULL, contentType=NULL, dataFileHandleId=NULL)`:
  Constructor for [`File`](https://r-docs.synapse.org/reference/File.md)
