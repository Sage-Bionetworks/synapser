# synGetSubmissions

Get submissions from an evaluation

## Usage

``` r
synGetSubmissions(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
```

## Arguments

- evaluation:

  Evaluation to get submissions from.  

- status:

  Optionally filter submissions for a specific status.  
  One of OPEN, CLOSED, SCORED,INVALID,VALIDATED,  
  EVALUATION_IN_PROGRESS,RECEIVED, REJECTED, ACCEPTED  

- myOwn:

  Determines if only your Submissions should be fetched.  
  Defaults to FALSE (all Submissions)  

- limit:

  Limits the number of submissions in a single response.  
  Because this method returns a generator and repeatedly  
  fetches submissions, this argument is limiting the  
  size of a single request and NOT the number of sub-  
  missions returned in total.  

- offset:

  Start iterating at a submission offset from the first  
  submission.

## Value

A generator over Submission objects for an Evaluation. Use
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
submissions<-synGetSubmissions("1234567")
} # }
```
