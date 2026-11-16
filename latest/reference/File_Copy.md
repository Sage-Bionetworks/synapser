# File : copy

Copy the file to another Synapse location. Defaults to the latest
version of the file, or the version_number specified in the instance.

## Usage

``` r
synCopy(instance, parent_id, update_existing=FALSE, copy_annotations=TRUE, copy_activity="traceback", synapse_client=NULL)
```

## Arguments

- instance:

  (File) The File instance to operate on.

- parent_id:

  (str) Synapse ID of a folder/project that the copied entity is being
  copied to

- update_existing:

  (bool) When the destination has a file that has the same name, users
  can choose to update that file.

- copy_annotations:

  (bool) TRUE to copy the annotations.

- copy_activity:

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

The copied file object.

## Errors

An error is raised if the file does not have an ID and parent_id to
copy.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you have a file with the ID "syn123" and you want to copy it to a
    # folder with the ID "syn456":
    new_file_instance = File(id = "syn123") |> synCopy(parent_id = "syn456")

    # Copy the file but do not persist annotations or activity:
    new_file_instance = File(id = "syn123") |> synCopy(parent_id = "syn456", copy_annotations = FALSE, copy_activity = NULL)
} # }
```
