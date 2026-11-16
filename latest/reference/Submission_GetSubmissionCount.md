# Submission : get_submission_count

Gets the number of Submissions for a specified Evaluation queue.

## Usage

``` r
synGetSubmissionCount(evaluation_id, synapse_client=NULL)
```

## Arguments

- evaluation_id:

  (character) The ID of the evaluation queue.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The API response containing the submission count.

## Examples

``` r
if (FALSE) { # \dontrun{
## Getting submission count
    # Get the total number of submissions from a specific evaluation.
    library(synapser)
    synLogin()

    response = synGetSubmissionCount(evaluation_id = "9999999")
    print(response)
} # }
```
