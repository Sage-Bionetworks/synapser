# Constructor for objects of type SubmissionStatus

Builds an Synapse submission status object.

## Usage

``` r
SubmissionStatus(score=NULL, status=NULL)
```

## Arguments

- score:

  optional named parameter: The score of the submission  

- status:

  optional named parameter: Status can be one of 'OPEN', 'CLOSED',
  'SCORED', 'INVALID'.

## Details

This constructor is not normally invoked by the client. The object is
created as a side effect of calling
[`synSubmit`](https://r-docs.synapse.org/reference/synSubmit.md) and is
retrieved by
[`synGetSubmissionStatus`](https://r-docs.synapse.org/reference/synGetSubmissionStatus.md).

## Value

An object of type SubmissionStatus

## See also

[`synSubmit`](https://r-docs.synapse.org/reference/synSubmit.md)
[`synGetSubmissionStatus`](https://r-docs.synapse.org/reference/synGetSubmissionStatus.md)
[`synGetSubmissionBundles`](https://r-docs.synapse.org/reference/synGetSubmissionBundles.md)
