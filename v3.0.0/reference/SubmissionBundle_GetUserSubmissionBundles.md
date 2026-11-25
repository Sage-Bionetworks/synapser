# SubmissionBundle : get_user_submission_bundles

Retrieves all user bundled Submissions and SubmissionStatuses for a
specified Evaluation.

## Usage

``` r
synGetUserSubmissionBundles(cls, evaluation_id, synapse_client=NULL)
```

## Arguments

- cls:

  (SubmissionBundle) The SubmissionBundle class (or an existing
  SubmissionBundle instance) to dispatch this call to.

- evaluation_id:

  (character) The ID of the specified Evaluation.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields
[`SubmissionBundle`](https://r-docs.synapse.org/v3.0.0/reference/SubmissionBundle.md)
objects as they are retrieved from the API. Use
[`as.list()`](https://rdrr.io/r/base/list.html) to materialize all
results into a list, or `nextElem()` to retrieve one
[`SubmissionBundle`](https://r-docs.synapse.org/v3.0.0/reference/SubmissionBundle.md)
at a time.

## Examples

``` r
if (FALSE) { # \dontrun{
## Getting user submission bundles
    library(synapser)
    synLogin()

    bundles = as.list(SubmissionBundle() |> synGetUserSubmissionBundles(
        evaluation_id = "9999999"
    ))
    print(sprintf("Found %d user submission bundles", length(bundles)))
    for (bundle in bundles) {
        print(sprintf("Submission ID: %s", bundle$submission$id))
    }
} # }
```
