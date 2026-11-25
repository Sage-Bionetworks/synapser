# Project : get_project_setting

Get the project setting for this entity.

## Usage

``` r
synGetProjectSetting(instance, setting_type="upload", synapse_client=NULL)
```

## Arguments

- instance:

  (Project) The Project instance to operate on.

- setting_type:

  (character) The type of setting to retrieve. Currently only 'upload'
  is supported.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The ProjectSetting object, or NULL if no setting exists.

## Errors

Raises an error if the entity does not have an id set.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Get the upload settings for a project:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    setting = project |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        print(sprintf("Storage locations: %s", paste(unlist(setting$locations), collapse = ", ")))
    }
} # }
```
