# StoreGridOptions

Options for storing Grid entities.

## Usage

``` r
StoreGridOptions(attach_to_previous_session=FALSE, timeout=120L)
```

## Format

An S3-style class object.

## Arguments

- attach_to_previous_session:

  (bool) If TRUE and using record_set_id, will attach to an existing
  active session if one exists.

- timeout:

  (int) The number of seconds to wait for the job to complete.

## Value

NULL

## Methods

- `StoreGridOptions(attach_to_previous_session=FALSE, timeout=120L)`:
  Constructor for `StoreGridOptions`

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this class
    # Pass to synStore() through the grid_options argument when storing a Grid
    grid_options = StoreGridOptions(attach_to_previous_session = TRUE, timeout = 300L)
} # }
```
