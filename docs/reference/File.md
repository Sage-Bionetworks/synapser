# Constructor for objects of type File

Represents a file in Synapse.

When a File object is stored, the associated local file or its URL will
be stored in Synapse. A File must have a path (or URL) and a parent.

## Usage

``` r
File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, name=NULL, contentType=NULL, dataFileHandleId=NULL)
```

## Arguments

- path:

  Location to be represented by this File  

- parent:

  Project or Folder where this File is stored  

- synapseStore:

  Whether the File should be uploaded or if only the path should be
  stored when synStore  
  is called on the File object. Defaults to TRUE (file should be
  uploaded)  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

- name:

  optional named parameter: Name of the file in Synapse, not to be
  confused with the name within the path  

- contentType:

  optional named parameter: Manually specify Content-type header, for
  example "application/png" or "application/json; charset=UTF-8"  

- dataFileHandleId:

  optional named parameter: Defining an existing dataFileHandleId will
  use the existing dataFileHandleId  
  The creator of the file must also be the owner of the dataFileHandleId
  to have permission to store the file  

## Value

An object of type File

## Examples

``` r
if (FALSE) { # \dontrun{
file<-File('/path/to/file/data.xyz', parent=folder)
file<-synStore(file)
} # }
```
