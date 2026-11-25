# StorageLocationType

Describes a Synapse storage location type.

Each instance is a distinct object identified by its `name`, so SFTP and
HTTPS remain separate even though they share the same backend
`concreteType` (`ExternalStorageLocationSetting`).

## Usage

``` r
StorageLocationType(name, concrete_type)
```

## Format

An S3-style class object.

## Arguments

- name:

  (character) Human-readable identifier (e.g. `"EXTERNAL_SFTP"`).

- concrete_type:

  (character) The `concreteType` suffix sent to the Synapse REST API.

## Value

NULL

## Supported storage location types

A `StorageLocationType` is identified by both its `name` and its
`concrete_type`, so construct it with one of the following pairs:

|                           |                                               |
|---------------------------|-----------------------------------------------|
| **name**                  | **concrete_type**                             |
| `"SYNAPSE_S3"`            | `"S3StorageLocationSetting"`                  |
| `"EXTERNAL_S3"`           | `"ExternalS3StorageLocationSetting"`          |
| `"EXTERNAL_GOOGLE_CLOUD"` | `"ExternalGoogleCloudStorageLocationSetting"` |
| `"EXTERNAL_SFTP"`         | `"ExternalStorageLocationSetting"`            |
| `"EXTERNAL_HTTPS"`        | `"ExternalStorageLocationSetting"`            |
| `"EXTERNAL_OBJECT_STORE"` | `"ExternalObjectStorageLocationSetting"`      |
| `"PROXY"`                 | `"ProxyStorageLocationSettings"`              |

## Methods

- `StorageLocationType(name, concrete_type)`: Constructor for
  `StorageLocationType`

## Examples

``` r
if (FALSE) { # \dontrun{
## Use a storage location type when creating a storage location
    library(synapser)
    synLogin()

    external_s3 = StorageLocationType(
        name = "EXTERNAL_S3",
        concrete_type = "ExternalS3StorageLocationSetting"
    )
    storage = StorageLocation(
        storage_type = external_s3,
        bucket = "my-external-synapse-bucket"
    ) |> synStore()
} # }
```
