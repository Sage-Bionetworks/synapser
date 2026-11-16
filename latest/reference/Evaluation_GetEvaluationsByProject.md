# Evaluation : get_evaluations_by_project

Get Evaluations tied to a project.

## Usage

``` r
synGetEvaluationsByProject(project_id, access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
```

## Arguments

- project_id:

  (str) The ID of the project (e.g., "syn123456").

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

A list of Evaluations tied to the project, as Evaluation objects.

## Errors

An error is raised if the service rejects the request or an HTTP error
occurs.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Get all evaluations for a project
    # The user must have at least READ access to the evaluations to retrieve the evaluations from a given project.
    library(synapser)
    synLogin()

    project_evaluations = synGetEvaluationsByProject(
        project_id = "syn123456"
    )
    project_evaluations

## Example 2: Get only active evaluations for a project
    library(synapser)
    synLogin()

    active_project_evaluations = synGetEvaluationsByProject(
        project_id = "syn123456",
        active_only = TRUE
    )
    active_project_evaluations

## Example 3: Get a limited set of evaluations for a project
    library(synapser)
    synLogin()

    limited_project_evaluations = synGetEvaluationsByProject(
        project_id = "syn123456",
        limit = 5L
    )
    limited_project_evaluations
} # }
```
