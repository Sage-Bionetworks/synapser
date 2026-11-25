# DatasetCollection : snapshot

Creates a snapshot of the dataset collection. A snapshot is a saved,
read-only version of the dataset collection at the time it was created.
Dataset collection snapshots are created using the asynchronous job API.

## Usage

``` r
synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)
```

## Arguments

- instance:

  (DatasetCollection) The DatasetCollection instance to operate on.

- comment:

  (Optional\[character\]) A unique comment to associate with the
  snapshot.

- label:

  (Optional\[character\]) A unique label to associate with the snapshot.

- include_activity:

  (logical) If TRUE the activity will be included in snapshot if it
  exists. In order to include the activity, the activity must have
  already been stored in Synapse by using the `$activity` attribute on
  the Dataset Collection and calling the
  [`synStore()`](https://r-docs.synapse.org/v3.0.0/reference/synStore.md)
  function on the Dataset Collection instance. Adding an activity to a
  snapshot of a dataset collection is meant to capture the provenance of
  the data at the time of the snapshot. Defaults to TRUE.

- associate_activity_to_new_version:

  (logical) If TRUE the activity will be associated with the new version
  of the dataset collection. If FALSE the activity will not be
  associated with the new version of the dataset collection. Defaults to
  TRUE.

- timeout:

  (integer) The number of seconds to wait for the async job to complete.
  Defaults to 120.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `TableUpdateTransaction` object which includes the version number of
the snapshot.

## Examples

``` r
if (FALSE) { # \dontrun{
## Save a snapshot of a Dataset Collection.
    library(synapser)
    synLogin()

    my_collection = DatasetCollection(id = "syn1234") |> synGet()
    my_collection |> synSnapshot(comment = "My first snapshot", label = "My first snapshot")
} # }
```
