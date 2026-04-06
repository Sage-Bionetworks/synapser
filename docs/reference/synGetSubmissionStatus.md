# synGetSubmissionStatus

Downloads the status of a Submission.

## Usage

``` r
synGetSubmissionStatus(submission)
```

## Arguments

- submission:

  The Submission to lookup

## Value

A SubmissionStatus object

## Examples

``` r
if (FALSE) { # \dontrun{
ss<-synGetSubmissionStatus(submissionId)
for (a in ss$annotations["longAnnos"]) message("annotation name: ", a$key, " value: ", a$value)
for (a in ss$annotations["stringAnnos"]) message("annotation name: ", a$key, " value: ", a$value)
for (a in ss$annotations["doubleAnnos"]) message("annotation name: ", a$key, " value: ", a$value)
} # }
```
