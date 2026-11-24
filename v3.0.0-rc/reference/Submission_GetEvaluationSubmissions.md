# Submission : get_evaluation_submissions

Retrieves all Submissions for a specified Evaluation queue.

## Usage

``` r
synGetEvaluationSubmissions(cls, evaluation_id, status=NULL, synapse_client=NULL)
```

## Arguments

- cls:

  (Submission) The Submission class (or an existing Submission instance)
  to dispatch this call to.

- evaluation_id:

  (character) The ID of the evaluation queue.

- status:

  (Optional\[character\]) Optionally filter submissions by a submission
  status, such as SCORED, VALID, INVALID, OPEN, CLOSED or
  EVALUATION_IN_PROGRESS.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields
[`Submission`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission.md)
objects as they are retrieved from the API. Use
[`as.list()`](https://rdrr.io/r/base/list.html) to materialize all
results into a list, or `nextElem()` to retrieve one
[`Submission`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission.md)
at a time.

## Examples

``` r
if (FALSE) { # \dontrun{
## Getting submissions for an evaluation
    # Get SCORED submissions from a specific evaluation.
    library(synapser)
    synLogin()

    submissions = as.list(Submission() |> synGetEvaluationSubmissions(
        evaluation_id = "9999999",
        status = "SCORED"
    ))
    print(sprintf("Found %d submissions", length(submissions)))
} # }
```
