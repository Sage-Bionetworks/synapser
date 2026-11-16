# ActivityOptions

Configuration options for entities that support activity/provenance
tracking.

This class controls whether activity information (provenance data)
should be included when retrieving entities. Activity information tracks
the computational steps, data sources, and relationships that led to the
creation of an entity.

## Usage

``` r
ActivityOptions(include_activity=FALSE)
```

## Format

An S3-style class object.

## Arguments

- include_activity:

  (bool) Whether to include activity/provenance information when
  retrieving the entity. If TRUE, the returned entity will have its
  activity attribute populated with provenance data (if available). If
  FALSE, the activity attribute will be NULL. Including activity may
  result in additional API calls and slower retrieval times. Default is
  FALSE.

## Value

NULL

## Methods

- `ActivityOptions(include_activity=FALSE)`: Constructor for
  `ActivityOptions`

## Note

Activity information is only available for entities that support
provenance tracking (File, Table, Dataset, etc...). For other entity
types, this option is ignored.

## Examples

``` r
if (FALSE) { # \dontrun{
    # Configure activity inclusion:
    library(synapser)

    # Include activity information
    with_activity = ActivityOptions(include_activity = TRUE)

    # Skip activity information (faster retrieval)
    without_activity = ActivityOptions(include_activity = FALSE)
} # }
```
