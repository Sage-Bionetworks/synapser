# Folder : copy

Copy the folder to another Synapse location. This will recursively copy
all Tables, Links, Files, and Folders within the folder.

## Usage

``` r
synCopy(instance, parent_id, copy_annotations=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

- parent_id:

  (str) Synapse ID of a folder/project that the copied entity is being
  copied to

- copy_annotations:

  (bool) TRUE to copy the annotations.

- exclude_types:

  (Optional\[list\[str\]\]) A list of entity types list("file", "table",
  "link") which determines which entity types to not copy. Defaults to
  an empty list.

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

The copied folder object.

## Errors

An error is raised if the folder does not have an ID and parent_id to
copy.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you have a folder with the ID "syn123" and you want to copy it to a
    # project with the ID "syn456":
    new_folder_instance = Folder(id = "syn123") |> synCopy(parent_id = "syn456")

    # Copy the folder but do not persist annotations:
    new_folder_instance = Folder(id = "syn123") |> synCopy(parent_id = "syn456", copy_annotations = FALSE)
} # }
```
