# Submission : get_user_submissions

Retrieves all user Submissions for a specified Evaluation queue.

## Usage

``` r
synGetUserSubmissions(cls, evaluation_id, synapse_client=NULL)
```

## Arguments

- cls:

  (Submission) The Submission class (or an existing Submission instance)
  to dispatch this call to.

- evaluation_id:

  (character) The ID of the evaluation queue.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields
[`Submission`](https://r-docs.synapse.org/v3.0.0/reference/Submission.md)
objects as they are retrieved from the API. Use
[`as.list()`](https://rdrr.io/r/base/list.html) to materialize all
results into a list, or `nextElem()` to retrieve one
[`Submission`](https://r-docs.synapse.org/v3.0.0/reference/Submission.md)
at a time.

## Examples

``` r
if (FALSE) { # \dontrun{
## Getting user submissions
    library(synapser)
    synLogin()

    submissions = as.list(Submission() |> synGetUserSubmissions(
        evaluation_id = "9999999"
    ))
    print(sprintf("Found %d user submissions", length(submissions)))
} # }
```
