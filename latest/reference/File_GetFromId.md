# File : from_id

Wrapper for
[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md).

## Usage

``` r
synGetFromId(cls, synapse_id, synapse_client=NULL)
```

## Arguments

- cls:

  (File) The File class (or an existing File instance) to dispatch this
  call to.

- synapse_id:

  (str) The ID of the file in Synapse.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The file object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you have a file with the ID "syn123":
    file_instance = File |> synGetFromId(synapse_id = "syn123")
} # }
```
