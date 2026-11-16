# Folder : get_project_setting

Get the project setting for this entity.

## Usage

``` r
synGetProjectSetting(instance, setting_type="upload", synapse_client=NULL)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

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
    # Get the upload settings for a folder:
    library(synapser)
    synLogin()

    folder = Folder(id = "syn123") |> synGet()
    setting = folder |> synGetProjectSetting(setting_type = "upload")
    if (!is.null(setting)) {
        print(sprintf("Storage locations: %s", paste(unlist(setting$locations), collapse = ", ")))
    }
} # }
```
