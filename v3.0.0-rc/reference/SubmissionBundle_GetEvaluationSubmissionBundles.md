# SubmissionBundle : get_evaluation_submission_bundles

Retrieves bundled Submissions and SubmissionStatuses for a given
Evaluation.

## Usage

``` r
synGetEvaluationSubmissionBundles(cls, evaluation_id, status=NULL, synapse_client=NULL)
```

## Arguments

- cls:

  (SubmissionBundle) The SubmissionBundle class (or an existing
  SubmissionBundle instance) to dispatch this call to.

- evaluation_id:

  (character) The ID of the specified Evaluation.

- status:

  (Optional\[character\]) Optionally filter submission bundles by
  status.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields
[`SubmissionBundle`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionBundle.md)
objects as they are retrieved from the API. Use
[`as.list()`](https://rdrr.io/r/base/list.html) to materialize all
results into a list, or `nextElem()` to retrieve one
[`SubmissionBundle`](https://r-docs.synapse.org/v3.0.0-rc/reference/SubmissionBundle.md)
at a time.

## Note

The caller must be granted the READ_PRIVATE_SUBMISSION [access
type](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html)
on the specified Evaluation.

## Examples

``` r
if (FALSE) { # \dontrun{
## Getting submission bundles for an evaluation
    library(synapser)
    synLogin()

    bundles = as.list(SubmissionBundle() |> synGetEvaluationSubmissionBundles(
        evaluation_id = "9999999",
        status = "SCORED"
    ))
    print(sprintf("Found %d submission bundles", length(bundles)))
    for (bundle in bundles) {
        submission_id = if (is.null(bundle$submission)) "N/A" else bundle$submission$id
        print(sprintf("Submission ID: %s", submission_id))
    }
} # }
```
