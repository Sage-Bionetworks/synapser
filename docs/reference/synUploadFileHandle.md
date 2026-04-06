# synUploadFileHandle

Uploads the file in the provided path (if necessary) to a storage
location based on project settings. Returns a new FileHandle as a named
list to represent the stored file.

## Usage

``` r
synUploadFileHandle(path, parent, synapseStore=TRUE, mimetype=NULL, md5=NULL, file_size=NULL, file_type=NULL)
```

## Arguments

- path:

  file path to the file being uploaded  

- parent:

  parent of the entity to which we upload.  

- synapseStore:

  If FALSE, will not upload the file, but instead create an
  ExternalFileHandle that references the file on the local machine.  
  If TRUE, will upload the file based on StorageLocation determined by
  the entity_parent_id  

- mimetype:

  The MIME type metadata for the uploaded file  

- md5:

  The MD5 checksum for the file, if known. Otherwise if the file is a
  local file, it will be calculated automatically.  

- file_size:

  The size the file, if known. Otherwise if the file is a local file, it
  will be calculated automatically.  

- file_type:

  Optional named parameter: The MIME type the file, if known. Otherwise
  if the file is a local file, it will be calculated automatically.

## Value

a new FileHandle (the metadata for the uploaded file) as a named list
