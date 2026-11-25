# Dataset : add_item

Adds an item in the form of an
[`EntityRef`](https://r-docs.synapse.org/v3.0.0/reference/EntityRef.md)
to the dataset. For Folders, children are added recursively. Effect is
not seen until the dataset is stored.

## Usage

``` r
synAddItem(instance, item, synapse_client=NULL)
```

## Arguments

- instance:

  (Dataset) The Dataset instance to operate on.

- item:

  (EntityRef, File, or Folder) Entity to add to the dataset. Must be an
  [`EntityRef`](https://r-docs.synapse.org/v3.0.0/reference/EntityRef.md),
  File, or Folder.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Errors

Raises an error if the item is not an EntityRef, File, or Folder.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Add a file to a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddItem(File(id = "syn1235"))
    my_dataset |> synStore()

## Example 2: Add a folder to a dataset.
    # All child files are recursively added to the dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddItem(Folder(id = "syn1236"))
    my_dataset |> synStore()

## Example 3: Add an entity reference to a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synAddItem(EntityRef(id = "syn1237", version = 1L))
    my_dataset |> synStore()
} # }
```
