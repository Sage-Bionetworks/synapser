# Project : copy

You must have already created the Project you will be copying to. It
will have its own Synapse ID and unique name that you will use as the
destination_id.

Copy the project to another Synapse project. This will recursively copy
all Tables, Links, Files, and Folders within the project.

## Usage

``` r
synCopy(instance, destination_id, copy_annotations=TRUE, copy_wiki=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)
```

## Arguments

- instance:

  (Project) The Project instance to operate on.

- destination_id:

  (str) Synapse ID of a project to copy to.

- copy_annotations:

  (bool) TRUE to copy the annotations.

- copy_wiki:

  (bool) TRUE to copy the wiki pages.

- exclude_types:

  (Optional\[list\[str\]\]) A list of entity types
  `list("file", "table", "link")` which determines which entity types to
  not copy. Defaults to an empty list.

- file_update_existing:

  (bool) When the destination has a file that has the same name, users
  can choose to update that file.

- file_copy_activity:

  (Optional\[str\]) Has three options to set the activity of the copied
  file:  
    
  - traceback: Creates a copy of the source files Activity.  
  - existing: Link to the source file's original Activity (if it
  exists)  
  - NULL: No activity is set

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The copied project object.

## Errors

An error is raised if the project does not have an ID and destination_id
to copy.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you have a project with the ID "syn123" and you want to copy it to a
    # project with the ID "syn456":
    library(synapser)
    synLogin()

    new_instance = Project(id = "syn123") |> synCopy(destination_id = "syn456")

    # Copy the project but do not persist annotations:
    new_instance = Project(id = "syn123") |> synCopy(destination_id = "syn456", copy_annotations = FALSE)
} # }
```
