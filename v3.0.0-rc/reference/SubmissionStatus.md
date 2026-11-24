# SubmissionStatus

A SubmissionStatus is a secondary, mutable object associated with a
Submission. This object should be used to contain scoring data about the
Submission.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatus.html>

## Usage

``` r
SubmissionStatus(id=NULL, etag=NULL, modified_on=NULL, status=NULL, score=NULL, report=NULL, annotations=list(), submission_annotations=list(), private_status_annotations=TRUE, entity_id=NULL, version_number=NULL, status_version=NULL, can_cancel=FALSE, cancel_requested=FALSE)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[character\]) The unique, immutable Synapse ID of the
  Submission.

- etag:

  (Optional\[character\]) Synapse employs an Optimistic Concurrency
  Control (OCC) scheme to handle concurrent updates. The eTag changes
  every time a SubmissionStatus is updated; it is used to detect when a
  client's copy of a SubmissionStatus is out-of-date.

- modified_on:

  (Optional\[character\]) The date on which this SubmissionStatus was
  last modified.

- status:

  (Optional\[character\]) The possible states of a Synapse Submission
  (e.g., RECEIVED, VALIDATED, SCORED).

- score:

  (Optional\[numeric\]) This field is deprecated and should not be used.
  Use the 'submission_annotations' field instead.

- report:

  (Optional\[character\]) This field is deprecated and should not be
  used. Use the 'submission_annotations' field instead.

- annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Primary container
  object for Annotations on a Synapse object. These annotations use the
  legacy format and do not show up in a submission view. The visibility
  is controlled by private_status_annotations.

- submission_annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Submission
  Annotations are additional key-value pair metadata that are associated
  with an object. These annotations use the modern nested format and
  show up in a submission view.

- private_status_annotations:

  (Optional\[logical\]) Indicates whether the annotations (not to be
  confused with submission annotations) are private (TRUE) or public
  (FALSE). Default is TRUE. This controls the visibility of the
  'annotations' field.

- entity_id:

  (Optional\[character\]) The Synapse ID of the Entity in this
  Submission.

- version_number:

  (Optional\[integer\]) The version number of the Entity in this
  Submission.

- status_version:

  (Optional\[integer\]) A version of the status, auto-generated and
  auto-incremented by the system and read-only to the client.

- can_cancel:

  (Optional\[logical\]) Can this submission be cancelled? By default,
  this will be set to FALSE. Users can read this value. Only the queue's
  scoring application can change this value.

- cancel_requested:

  (Optional\[logical\]) Has user requested to cancel this submission? By
  default, this will be set to FALSE. Submission owner can read and
  request to change this value.

## Value

NULL

## Methods

- `SubmissionStatus(id=NULL, etag=NULL, modified_on=NULL, status=NULL, score=NULL, report=NULL, annotations=list(), submission_annotations=list(), private_status_annotations=TRUE, entity_id=NULL, version_number=NULL, status_version=NULL, can_cancel=FALSE, cancel_requested=FALSE)`:
  Constructor for `SubmissionStatus`

- [`synBatchUpdateSubmissionStatuses`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionStatus_BatchUpdateSubmissionStatuses.md)`(evaluation_id, statuses, is_first_batch=TRUE, is_last_batch=TRUE, batch_token=NULL, synapse_client=NULL)`:
  Update multiple SubmissionStatuses. The maximum batch size is 500.

- [`synGetAllSubmissionStatuses`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionStatus_GetAllSubmissionStatuses.md)`(evaluation_id, status=NULL, limit=10L, offset=0L, synapse_client=NULL)`:
  Gets a collection of SubmissionStatuses to a specified Evaluation.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Retrieve and update a SubmissionStatus.
    # This example demonstrates the basic workflow of retrieving an existing submission status, updating its fields, and storing the changes back to Synapse.
    library(synapser)
    synLogin()

    # Get a submission status
    status = SubmissionStatus(id = "9999999") |> synGet()

    # Update the status
    status$status = "SCORED"
    status$submission_annotations = list(score = list(85.5), feedback = list("Good work!"))
    status = status |> synStore()
    print(status)

## Example 2: Get all submission statuses for an evaluation.
    # Retrieve multiple submission statuses for an evaluation queue with optional filtering.
    library(synapser)
    synLogin()

    # Get all RECEIVED statuses for an evaluation
    statuses = synGetAllSubmissionStatuses(
        evaluation_id = "9999999",
        status = "RECEIVED",
        limit = 100L
    )

    print(sprintf("Found %d submission statuses", length(statuses)))
    for (status in statuses) {
        print(sprintf("Status ID: %s, Status: %s", status$id, status$status))
    }

## Example 3: Batch update multiple submission statuses.
    # Efficiently update multiple submission statuses in a single operation.
    library(synapser)
    synLogin()

    # Retrieve statuses to update
    statuses = synGetAllSubmissionStatuses(
        evaluation_id = "9999999",
        status = "RECEIVED"
    )

    # Update each status
    for (status in statuses) {
        status$status = "SCORED"
        status$submission_annotations = list(
            validation_score = 95.0,
            comments = "Passed validation"
        )
    }

    # Batch update all statuses
    response = synBatchUpdateSubmissionStatuses(
        evaluation_id = "9999999",
        statuses = statuses
    )
    print(response)
} # }
```
