# StorageLocation

A storage location setting describes where files are uploaded to and
downloaded from via Synapse. Storage location settings may be created
for external locations, such as user-owned Amazon S3 buckets, Google
Cloud Storage buckets, SFTP servers, or proxy storage.

## Usage

``` r
StorageLocation(storage_location_id=NULL, storage_type=NULL, concrete_type=NULL, banner=NULL, description=NULL, bucket=NULL, base_key=NULL, sts_enabled=FALSE, endpoint_url="https://s3.amazonaws.com", url=NULL, supports_subfolders=FALSE, proxy_url=NULL, secret_key=NULL, benefactor_id=NULL, upload_type=NULL, etag=NULL, created_on=NULL, created_by=NULL)
```

## Format

An S3-style class object.

## Arguments

- storage_location_id:

  (Optional\[integer\]) (Read Only) The unique ID for this storage
  location, assigned by the server on creation.

- storage_type:

  (Optional\[StorageLocationType\]) The type of storage location, a
  [`StorageLocationType`](https://r-docs.synapse.org/latest/reference/StorageLocationType.md).
  Required when creating a new storage location via
  [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md).
  Determines the `concreteType` sent to the Synapse REST API.

- concrete_type:

  (Optional\[character\]) The concrete type of the storage location
  indicating which implementation this object represents.

- banner:

  (Optional\[character\]) The banner text to display to a user every
  time a file is uploaded. This field is optional.

- description:

  (Optional\[character\]) A description of the storage location. This
  description is shown when a user has to choose which upload
  destination to use.

- bucket:

  (Optional\[character\]) The name of the S3 or Google Cloud Storage
  bucket. Applicable to `SYNAPSE_S3`, `EXTERNAL_S3`,
  `EXTERNAL_GOOGLE_CLOUD`, and `EXTERNAL_OBJECT_STORE` types.

- base_key:

  (Optional\[character\]) The optional base key (prefix/folder) within
  the bucket. Applicable to `SYNAPSE_S3`, `EXTERNAL_S3`, and
  `EXTERNAL_GOOGLE_CLOUD` types.

- sts_enabled:

  (Optional\[logical\]) Whether STS (AWS Security Token Service) is
  enabled on this storage location. Applicable to `SYNAPSE_S3` and
  `EXTERNAL_S3` types.

- endpoint_url:

  (Optional\[character\]) The endpoint URL of the S3 service. Applicable
  to `EXTERNAL_S3` (default: https://s3.amazonaws.com) and
  `EXTERNAL_OBJECT_STORE` types.

- url:

  (Optional\[character\]) The base URL for uploading to the external
  destination. Applicable to `EXTERNAL_SFTP` type.

- supports_subfolders:

  (Optional\[logical\]) Whether the destination supports creating
  subfolders under the base url. Applicable to `EXTERNAL_SFTP` type.
  Default: FALSE.

- proxy_url:

  (Optional\[character\]) The HTTPS URL of the proxy used for upload and
  download. Applicable to `PROXY` type.

- secret_key:

  (Optional\[character\]) The encryption key used to sign all pre-signed
  URLs used to communicate with the proxy. Applicable to `PROXY` type.

- benefactor_id:

  (Optional\[character\]) An Entity ID (such as a Project ID). When set,
  any user with the 'create' permission on the given benefactorId will
  be allowed to create ProxyFileHandle using its storage location ID.
  Applicable to `PROXY` type.

- upload_type:

  (Optional\[UploadType\]) (Read Only) The upload type for this storage
  location. Automatically derived from `storage_type`.

- etag:

  (Optional\[character\]) (Read Only) Synapse employs an Optimistic
  Concurrency Control (OCC) scheme. The E-Tag changes every time the
  setting is updated.

- created_on:

  (Optional\[character\]) (Read Only) The date this storage location
  setting was created.

- created_by:

  (Optional\[integer\]) (Read Only) The ID of the user that created this
  storage location setting.

## Value

NULL

## Methods

- `StorageLocation(storage_location_id=NULL, storage_type=NULL, concrete_type=NULL, banner=NULL, description=NULL, bucket=NULL, base_key=NULL, sts_enabled=FALSE, endpoint_url="https://s3.amazonaws.com", url=NULL, supports_subfolders=FALSE, proxy_url=NULL, secret_key=NULL, benefactor_id=NULL, upload_type=NULL, etag=NULL, created_on=NULL, created_by=NULL)`:
  Constructor for `StorageLocation`

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Creating an external S3 storage location
    # Create a storage location backed by your own S3 bucket:
    library(synapser)
    synLogin()

    storage = StorageLocation(
        storage_type = StorageLocationType(
            name = "EXTERNAL_S3",
            concrete_type = "ExternalS3StorageLocationSetting"
        ),
        bucket = "my-external-synapse-bucket",
        base_key = "path/within/bucket"
    ) |> synStore()

    print(sprintf("Storage location ID: %s", storage$storage_location_id))

## Example 2: Creating a Google Cloud storage location
    # Create a storage location backed by your own GCS bucket:
    library(synapser)
    synLogin()

    storage = StorageLocation(
        storage_type = StorageLocationType(
            name = "EXTERNAL_GOOGLE_CLOUD",
            concrete_type = "ExternalGoogleCloudStorageLocationSetting"
        ),
        bucket = "my-gcs-bucket",
        base_key = "path/within/bucket"
    ) |> synStore()

## Example 3: Retrieving a storage location by ID
    # Only the creator of a storage location can retrieve it by its ID.
    library(synapser)
    synLogin()

    storage = StorageLocation(storage_location_id = 12345L) |> synGet()
    print(sprintf("Type: %s, Bucket: %s", storage$storage_type$name, storage$bucket))
} # }
```
