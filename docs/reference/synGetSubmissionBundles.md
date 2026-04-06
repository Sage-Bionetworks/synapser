# synGetSubmissionBundles

Retrieve submission bundles (submission and submissions status) for an
evaluation queue, optionally filtered by submission status and/or owner.

## Usage

``` r
synGetSubmissionBundles(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
```

## Arguments

- evaluation:

  Evaluation to get submissions from.  

- status:

  Optionally filter submissions for a specific status.  
  One of OPEN, CLOSED, SCORED, INVALID  

- myOwn:

  Determines if only your Submissions should be fetched.  
  Defaults to FALSE (all Submissions)  

- limit:

  Limits the number of submissions coming back from the  
  service in a single response.  

- offset:

  Start iterating at a submission offset from the first  
  submission.

## Value

A generator over tuples containing a Submission and a SubmissionStatus.
Use [`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundles<-synGetSubmissionBundles(evaluation)
} # }
```
