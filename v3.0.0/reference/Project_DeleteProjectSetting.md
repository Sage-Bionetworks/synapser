# Project : delete_project_setting

Delete a project setting by its setting ID.

## Usage

``` r
synDeleteProjectSetting(instance, setting_id, synapse_client=NULL)
```

## Arguments

- instance:

  (Project) The Project instance to operate on.

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
    # Delete the upload settings for a project:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        project |> synDeleteProjectSetting(setting_id = setting$id)
    }
} # }
```
