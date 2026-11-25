# DatasetCollection : add_item

Adds a dataset to the dataset collection. Effect is not seen until the
dataset collection is stored.

## Usage

``` r
synAddItem(instance, item)
```

## Arguments

- instance:

  (DatasetCollection) The DatasetCollection instance to operate on.

- item:

  (Dataset or EntityRef) Dataset to add to the collection. Must be a
  Dataset or an
  [`EntityRef`](https://r-docs.synapse.org/v3.0.0/reference/EntityRef.md)
  pointing to one.

## Value

NULL

## Errors

Raises an error if the item is not a Dataset or EntityRef.

## Examples

``` r
if (FALSE) { # \dontrun{
## Add a Dataset to a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synAddItem(Dataset(id = "syn1235"))
    my_collection |> synStore()
} # }
```
