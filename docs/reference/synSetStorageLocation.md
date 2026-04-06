# synSetStorageLocation

Sets the storage location for a Project or Folder

## Usage

``` r
synSetStorageLocation(entity, storage_location_id)
```

## Arguments

- entity:

  a Project or Folder to which the StorageLocationSetting is set  

- storage_location_id:

  a StorageLocation id or a list of StorageLocation ids. Pass in NULL
  for the default Synapse storage.

## Value

The created or updated settings as a named list.
