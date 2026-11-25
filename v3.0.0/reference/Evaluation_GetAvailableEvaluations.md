# Evaluation : get_available_evaluations

Get a list of Evaluations to which the user has SUBMIT permission,
within a given range.

## Usage

``` r
synGetAvailableEvaluations(active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
```

## Arguments

- active_only:

  (Optional\[bool\]) If TRUE then return only those evaluations with
  rounds defined and for which the current time is in one of the rounds.

- evaluation_ids:

  (Optional\[list\[str\]\]) An optional list of evaluation IDs to which
  the response is limited.

- offset:

  (Optional\[int\]) The offset index determines where this page will
  start from. An index of 0 is the first entity. When NULL it will
  default to 0.

- limit:

  (Optional\[int\]) Limits the number of entities that will be fetched
  for this page. When NULL it will default to 10.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A list of available evaluations, as Evaluation objects.

## Errors

An error is raised if the service rejects the request or an HTTP error
occurs.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Get all evaluations where the current user has SUBMIT permission
    # A default call will return evaluations where the user has SUBMIT permission, without needing to specify access type.
    library(synapser)
    synLogin()

    available_evaluations = synGetAvailableEvaluations()
    available_evaluations

## Example 2: Get only active evaluations where the current user has SUBMIT permission
    library(synapser)
    synLogin()

    active_available_evaluations = synGetAvailableEvaluations(
        active_only = TRUE
    )
    active_available_evaluations

## Example 3: Get the first 5 evaluations where the current user has SUBMIT permission
    library(synapser)
    synLogin()

    limited_evaluations = synGetAvailableEvaluations(
        limit = 5L
    )
    limited_evaluations
} # }
```
