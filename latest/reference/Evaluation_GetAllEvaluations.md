# Evaluation : get_all_evaluations

Get a list of all Evaluations, within a given range.

## Usage

``` r
synGetAllEvaluations(access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
```

## Arguments

- access_type:

  (Optional\[str\]) The type of access for the user to filter for,
  optional and defaults to `"READ"`. See
  [ACCESS_TYPE](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html)
  for the available values.

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

A list of all evaluations, as Evaluation objects.

## Errors

An error is raised if the service rejects the request or an HTTP error
occurs.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Get all evaluations the user has at least READ access to
    # A default call will return evaluations where the user has read access, without needing to specify access type.
    library(synapser)
    synLogin()

    all_evaluations = synGetAllEvaluations()
    all_evaluations

## Example 2: Get only active evaluations with a limit
    library(synapser)
    synLogin()

    active_evaluations = synGetAllEvaluations(
        active_only = TRUE,
        limit = 20L
    )
    active_evaluations

## Example 3: Get specific evaluations by ID
    library(synapser)
    synLogin()

    specific_evaluations = synGetAllEvaluations(
        evaluation_ids = list("9999991", "9999992")
    )
    specific_evaluations
} # }
```
