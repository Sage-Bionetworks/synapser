# Folder : map_directory_to_all_contained_files

Recursively loop over all of the already retrieved files and folders.
Then return back a named list where the key is the path to the directory
at each level. The value is a list of all files in that directory AND
all files in the child directories.

This is used during the creation of the manifest TSV file during the
syncFromSynapse utility function.

## Usage

``` r
synMapDirectoryToAllContainedFiles(instance, root_path)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

- root_path:

  (str) The root path where the top level files are stored.

## Value

A named list where the key is the path to the directory at each level.
The value is a list of all files in that directory AND all files in the
child directories.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Returning back a named list with 2 keys:
    #
    # Given:
    # root_folder
    # |-- sub_folder
    # |   |-- file1.txt
    # |   `-- file2.txt
    #
    # Returns:
    # list(
    #     "root_folder" = list(file1, file2),
    #     "root_folder/sub_folder" = list(file1, file2)
    # )

    # Returning back a named list with 3 keys:
    #
    # Given:
    # root_folder
    # |-- sub_folder_1
    # |   |-- file1.txt
    # |-- sub_folder_2
    # |   `-- file2.txt
    #
    # Returns:
    # list(
    #     "root_folder" = list(file1, file2),
    #     "root_folder/sub_folder_1" = list(file1),
    #     "root_folder/sub_folder_2" = list(file2)
    # )
} # }
```
