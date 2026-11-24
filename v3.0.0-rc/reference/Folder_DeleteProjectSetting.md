# Folder : delete_project_setting

Delete a project setting by its setting ID.

## Usage

``` r
synDeleteProjectSetting(instance, setting_id, synapse_client=NULL)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

- setting_id:

  (character) The ID of the project setting to delete.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Errors

Raises an error if the entity does not have an id set.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Delete the upload settings for a folder:
    library(synapser)
    synLogin()

    folder = Folder(id = "syn123") |> synGet()
    setting = folder |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        folder |> synDeleteProjectSetting(setting_id = setting$id)
    }
} # }
```
