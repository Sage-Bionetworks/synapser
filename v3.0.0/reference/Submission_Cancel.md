# Submission : cancel

Cancel a Submission. Only the user who created the Submission may cancel
it.

## Usage

``` r
synCancel(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Submission) The Submission instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The updated Submission object.

## Errors

Raises an error if the submission does not have an ID to cancel.

## Examples

``` r
if (FALSE) { # \dontrun{
## Cancel a submission
library(synapser)

synLogin()

submission = Submission(id = "syn1234")
canceled_submission = submission |> synCancel()
print(sprintf("Canceled submission: %s", canceled_submission$id))
} # }
```
