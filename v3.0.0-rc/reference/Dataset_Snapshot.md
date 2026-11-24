# Dataset : snapshot

Creates a snapshot of the dataset. A snapshot is a saved, read-only
version of the dataset at the time it was created. Dataset snapshots are
created using the asynchronous job API.

## Usage

``` r
synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)
```

## Arguments

- instance:

  (Dataset) The Dataset instance to operate on.

- comment:

  (Optional\[character\]) A unique comment to associate with the
  snapshot.

- label:

  (Optional\[character\]) A unique label to associate with the snapshot.

- include_activity:

  (logical) If TRUE the activity will be included in snapshot if it
  exists. In order to include the activity, the activity must have
  already been stored in Synapse by using the `$activity` attribute on
  the Dataset and calling the
  [`synStore()`](https://r-docs.synapse.org/v3.0.0-rc/reference/synStore.md)
  function on the Dataset instance. Adding an activity to a snapshot of
  a dataset is meant to capture the provenance of the data at the time
  of the snapshot. Defaults to TRUE.

- associate_activity_to_new_version:

  (logical) If TRUE the activity will be associated with the new version
  of the dataset. If FALSE the activity will not be associated with the
  new version of the dataset. Defaults to TRUE.

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
## Save a snapshot of a dataset.
    library(synapser)
    synLogin()

    my_dataset = Dataset(id = "syn1234") |> synGet()
    my_dataset |> synSnapshot(comment = "My first snapshot", label = "My first snapshot")
} # }
```
