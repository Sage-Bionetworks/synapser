# Dataset : remove_item

Removes an item from the dataset. For Folders, all children of the
folder are removed recursively. Effect is not seen until the dataset is
stored.

## Usage

``` r
synRemoveItem(instance, item, synapse_client=NULL)
```

## Arguments

- instance:

  (Dataset) The Dataset instance to operate on.

- item:

  (EntityRef, File, or Folder) The entity to remove from the dataset.
  Must be an
  [`EntityRef`](https://r-docs.synapse.org/v3.0.0-rc/reference/EntityRef.md),
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
## Example 1: Remove a file from a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synRemoveItem(File(id = "syn1235"))
    my_dataset |> synStore()

## Example 2: Remove a folder from a dataset.
    # All child files are recursively removed from the dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synRemoveItem(Folder(id = "syn1236"))
    my_dataset |> synStore()

## Example 3: Remove an entity reference from a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synRemoveItem(EntityRef(id = "syn1237", version = 1L))
    my_dataset |> synStore()
} # }
```
