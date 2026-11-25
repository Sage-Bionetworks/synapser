# Table : delete_rows

Delete rows from a table given a query or a data frame to select rows.
The query at a minimum must select the `ROW_ID` and `ROW_VERSION`
columns. If you want to inspect the data that will be deleted ahead of
time you may use the `synQuery()` function to get the data. The data
frame must at least contain the `ROW_ID` and `ROW_VERSION` columns. And
`ROW_ETAG` column is also required if the entity is one of the
following: `EntityView`, `Dataset`, `DatasetCollection`, or
`SubmissionView`. If both query and df are provided, the query will be
used.

## Usage

``` r
synDeleteRows(instance, query=NULL, df=NULL, job_timeout=600L, synapse_client=NULL)
```

## Arguments

- instance:

  (Table) The Table instance to operate on.

- query:

  (Optional\[str\]) The query to select the rows to delete. The query at
  a minimum must select the `ROW_ID` and `ROW_VERSION` columns. See this
  document that describes the expected syntax of the query:
  \<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html\>

- df:

  (Optional\[data.frame\]) A data frame that contains the rows to
  delete. The data frame must at least contain the `ROW_ID` and
  `ROW_VERSION` columns. If the entity is one of the following:
  `EntityView`, `Dataset`, `DatasetCollection`, or `SubmissionView` then
  the data frame must also contain the `ROW_ETAG` column. See this
  document that describes the expected columns of the data frame:
  \<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/Row.html\>

- job_timeout:

  (int) The amount of time to wait for table updates to complete before
  a timeout error is thrown. The default is 600 seconds.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The results of your query or data frame for the rows that were deleted
from the table.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Selecting a row to delete
    # This example shows how you may select a row to delete from a table.
    library(synapser)
    synLogin()

    # Also works with Dataset
    Table(id = "syn1234") |> synDeleteRows(query = "SELECT ROW_ID, ROW_VERSION FROM syn1234 WHERE foo = 'asdf'")

## Example 2: Selecting all rows that contain a null value
    # This example shows how you may select a row to delete from a table where
    # a column has a null value.
    library(synapser)
    synLogin()

    # Also works with Dataset
    Table(id = "syn1234") |> synDeleteRows(query = "SELECT ROW_ID, ROW_VERSION FROM syn1234 WHERE foo is null")

## Example 3: Selecting rows to delete using a data frame
    # This example shows how you may select a row to delete from a table based on a data frame.
    library(synapser)
    synLogin()

    # Creating a data frame that contains the rows to delete.
    # In this example, we create a data frame that specifies the first two rows of the table for deletion.
    # Assuming no changes have been made to the table so the ROW_VERSION is 1L.

    df = data.frame(ROW_ID = c(1L, 2L), ROW_VERSION = c(1L, 1L  ))
    Table(id = "syn1234") |> synDeleteRows(df = df)
} # }
```
