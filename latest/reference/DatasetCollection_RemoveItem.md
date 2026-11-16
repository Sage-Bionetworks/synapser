# DatasetCollection : remove_item

Removes an entity from the dataset collection. Must be a Dataset or
EntityRef. Effect is not seen until the dataset collection is stored.
Unless the version is specified, all entities with the same ID will be
removed.

## Usage

``` r
synRemoveItem(instance, item)
```

## Arguments

- instance:

  (DatasetCollection) The DatasetCollection instance to operate on.

- item:

  (Dataset or EntityRef) The Dataset, or an
  [`EntityRef`](https://r-docs.synapse.org/latest/reference/EntityRef.md)
  pointing to one, to remove from the collection.

## Value

NULL

## Errors

Raises an error if the item is not a Dataset or EntityRef.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Remove a Dataset from a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synRemoveItem(Dataset(id = "syn1235", version_number = 1L))
    my_collection |> synStore()

## Example 2: Remove all versions of a Dataset from a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synRemoveItem(Dataset(id = "syn1235"))
    my_collection |> synStore()
} # }
```
