# Dataset : query

Query for data on a table stored in Synapse. The results will always be
returned as a data frame unless you specify a `download_location` in
which case the results will be downloaded to that location. There are a
number of arguments that you may pass to this function depending on if
you are getting the results back as a data frame or downloading the
results to a file.

## Usage

``` r
synQuery(query, include_row_id_and_row_version=TRUE, convert_to_datetime=FALSE, download_location=NULL, quote_character="\"", escape_character=r"(\)", line_end="\n", separator=",", header=TRUE, timeout=250L, synapse_client=NULL)
```

## Arguments

- query:

  (character) The query to run. The query must be valid syntax that
  Synapse can understand. See this document that describes the expected
  syntax of the query:
  <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html>

- include_row_id_and_row_version:

  (logical) If TRUE the `ROW_ID` and `ROW_VERSION` columns will be
  returned in the data frame. These columns are required if using the
  query results to update rows in the table. These columns are the
  primary keys used by Synapse to uniquely identify rows in the table.

- convert_to_datetime:

  (logical) (data frame only) If set to TRUE, will convert all Synapse
  DATE columns from UNIX timestamp integers into UTC datetime objects

- download_location:

  (CSV Only) If set to a path the results will be downloaded to that
  directory. The results will be downloaded as a CSV file. A path to the
  downloaded file will be returned instead of a data frame.

- quote_character:

  (CSV Only) The character to use to quote fields. The default is a
  double quote.

- escape_character:

  (CSV Only) The character to use to escape special characters. The
  default is a backslash.

- line_end:

  (CSV Only) The character to use to end a line. The default is the
  system's line separator.

- separator:

  (CSV Only) The character to use to separate fields. The default is a
  comma.

- header:

  (CSV Only) If set to TRUE the first row will be used as the header
  row. The default is TRUE.

- timeout:

  (integer) The number of seconds to wait for the query job to complete
  or progress before raising a timeout error. Defaults to 250.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The results of the query as a data frame or a path to the downloaded
query results if `download_location` is set.

## Examples

``` r
if (FALSE) { # \dontrun{
## Querying for data
    # This example shows how you may query for data in a dataset and print out
    # the results.
    library(synapser)
    synLogin()

    results = synQuery(query = "SELECT * FROM syn1234")
    print(results)
} # }
```
