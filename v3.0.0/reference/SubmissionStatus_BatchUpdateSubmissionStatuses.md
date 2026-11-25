# SubmissionStatus : batch_update_submission_statuses

Update multiple SubmissionStatuses. The maximum batch size is 500.

## Usage

``` r
synBatchUpdateSubmissionStatuses(evaluation_id, statuses, is_first_batch=TRUE, is_last_batch=TRUE, batch_token=NULL, synapse_client=NULL)
```

## Arguments

- evaluation_id:

  (character) The ID of the Evaluation to which the SubmissionStatus
  objects belong.

- statuses:

  (list\[SubmissionStatus\]) List of SubmissionStatus objects to update.

- is_first_batch:

  (logical) Whether this is the first batch in the series. Default TRUE.

- is_last_batch:

  (logical) Whether this is the last batch in the series. Default TRUE.

- batch_token:

  (Optional\[character\]) Token from previous batch response (required
  for all but first batch).

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A BatchUploadResponse as a named list containing the batch token and
other response information.

## Examples

``` r
if (FALSE) { # \dontrun{
## Batch update submission statuses
    # Update multiple submission statuses in a single batch operation for efficiency.
    library(synapser)
    synLogin()

    # Retrieve existing statuses to update
    statuses = synGetAllSubmissionStatuses(
        evaluation_id = "9999999",
        status = "RECEIVED"
    )

    # Modify statuses as needed
    for (status in statuses) {
        status$status = "SCORED"
    }

    # Update statuses in batch
    response = synBatchUpdateSubmissionStatuses(
        evaluation_id = "9999999",
        statuses = statuses,
        is_first_batch = TRUE,
        is_last_batch = TRUE
    )
    print(response)
} # }
```
