# Project : set_storage_location

Set the upload storage location for this entity. This configures where
files uploaded to this entity will be stored.

**This is a destructive update.** The provided `storage_location_id`
value(s) will **replace** any storage locations previously configured on
this entity. To add a storage location without removing existing ones,
first retrieve the current setting with
[`synGetProjectSetting()`](https://r-docs.synapse.org/v3.0.0-rc/reference/Project_GetProjectSetting.md),
then pass its existing `locations` together with the new ID as
`storage_location_id`. The first ID in the list is the default upload
destination.

## Usage

``` r
synSetStorageLocation(instance, storage_location_id=1L, synapse_client=NULL)
```

## Arguments

- instance:

  (Project) The Project instance to operate on.

- storage_location_id:

  (Optional\[integer or list of integer\]) The storage location ID(s) to
  set. Can be a single ID, a list of IDs (first is default, max 10). By
  default, the default Synapse S3 storage location is used.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The ProjectSetting object reflecting the current state after the
operation.

## Errors

Raises an error if the entity does not have an id set.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Replace all storage locations
    # Fully replace the storage location on a project with a single location:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synSetStorageLocation(storage_location_id = 12345L)
    print(setting)

## Example 2: Partial update — add a storage location without removing existing ones
    # Retrieve the current setting and set the existing locations plus a new one:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        locations = c(unlist(setting$locations), 67890L)
        project |> synSetStorageLocation(storage_location_id = as.list(locations))
    }
} # }
```
