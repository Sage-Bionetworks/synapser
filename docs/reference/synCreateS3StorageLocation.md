# synCreateS3StorageLocation

Create a storage location in the given parent, either in the given
folder or by creating a new folder in that parent with the given name.
This will both create a StorageLocationSetting, and a ProjectSetting
together, optionally creating a new folder in which to locate it, and
optionally enabling this storage location for access via STS. If
enabling an existing folder for STS, it must be empty.

## Usage

``` r
synCreateS3StorageLocation(parent=NULL, folder_name=NULL, folder=NULL, bucket_name=NULL, base_key=NULL, sts_enabled=FALSE)
```

## Arguments

- parent:

  The parent in which to locate the storage location (mutually exclusive
  with folder)  

- folder_name:

  The name of a new folder to create (mutually exclusive with folder)  

- folder:

  The existing folder in which to create the storage location  
  (mutually exclusive with folder_name)  

- bucket_name:

  The name of an S3 bucket, if this is an external storage location,  
  if None will use Synapse S3 storage  

- base_key:

  The base key of within the bucket, None to use the bucket root,  
  only applicable if bucket_name is passed  

- sts_enabled:

  Whether this storage location should be STS enabled

## Value

a 3 element list of the synapse Folder, a the storage location setting,
and the project setting dictionaries

## Examples

``` r
if (FALSE) { # \dontrun{
folder_and_storage_location <- synCreateS3StorageLocation(parent='syn123', folder_name='test_folder', bucket_name='aws-bucket-name', base_key='key/in/bucket', sts_enabled=TRUE)

folder <- folder_and_storage_location[[1]]
storage_location <- folder_and_storage_location[[2]]

} # }
```
