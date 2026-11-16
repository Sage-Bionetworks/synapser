# StoreTableOptions

Options for storing Table-like entities.

## Usage

``` r
StoreTableOptions(dry_run=FALSE, job_timeout=600L)
```

## Format

An S3-style class object.

## Arguments

- dry_run:

  (bool) If TRUE, will not actually store but will log what would be
  done.

- job_timeout:

  (int) Maximum time to wait for table schema update job to complete.

## Value

NULL

## Methods

- `StoreTableOptions(dry_run=FALSE, job_timeout=600L)`: Constructor for
  `StoreTableOptions`

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this class
    # Preview a table schema change without applying it
    library(synapser)
    synLogin()

    table = Table(id = "syn123") |> synGet()
    table |> synAddColumn(Column(name = "new_column", column_type = "STRING"))
    table |> synStore(table_options = StoreTableOptions(dry_run = TRUE))
} # }
```
