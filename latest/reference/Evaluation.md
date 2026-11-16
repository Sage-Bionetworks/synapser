# Evaluation

An Evaluation is the core object of the Evaluation API, used to support
collaborative data analysis challenges in Synapse.

An `Evaluation` object represents an evaluation queue in Synapse:
<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/Evaluation.html>

## Usage

``` r
Evaluation(id=NULL, etag=NULL, name=NULL, description=NULL, owner_id=NULL, created_on=NULL, content_source=NULL, submission_instructions_message=NULL, submission_receipt_message=NULL)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique immutable ID for this Evaluation.

- etag:

  (Optional\[str\]) Synapse employs an Optimistic Concurrency Control
  (OCC) scheme to handle concurrent updates. The eTag changes every time
  an Evaluation is updated; it is used to detect when a client's copy of
  an Evaluation is out-of-date.

- name:

  (Optional\[str\]) \*\*Required to store.\*\* The name of this
  Evaluation.

- description:

  (Optional\[str\])\*\*Required to store.\*\* A text description of this
  Evaluation.

- owner_id:

  (Optional\[str\]) The ID of the Synapse user who created this
  Evaluation.

- created_on:

  (Optional\[str\]) The date on which Evaluation was created.

- content_source:

  (Optional\[str\])\*\*Required to store.\*\* The Synapse ID of the
  Entity to which this Evaluation belongs, e.g. a reference to a Synapse
  project.

- submission_instructions_message:

  (Optional\[str\]) \*\*Required to store.\*\* Message to display to
  users detailing acceptable formatting for Submissions to this
  Evaluation.

- submission_receipt_message:

  (Optional\[str\]) \*\*Required to store.\*\* Message to display to
  users upon successful submission to this Evaluation.

## Value

NULL

## Methods

- `Evaluation(id=NULL, etag=NULL, name=NULL, description=NULL, owner_id=NULL, created_on=NULL, content_source=NULL, submission_instructions_message=NULL, submission_receipt_message=NULL)`:
  Constructor for `Evaluation`

- [`synGetAcl`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAcl.md)`(instance, synapse_client=NULL)`:
  Get the access control list (ACL) governing this evaluation.

- [`synGetAllEvaluations`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAllEvaluations.md)`(access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)`:
  Get a list of all Evaluations, within a given range.

- [`synGetAvailableEvaluations`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAvailableEvaluations.md)`(active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)`:
  Get a list of Evaluations to which the user has SUBMIT permission,
  within a given range.

- [`synGetEvaluationsByProject`](https://r-docs.synapse.org/latest/reference/Evaluation_GetEvaluationsByProject.md)`(project_id, access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)`:
  Get Evaluations tied to a project.

- [`synGetPermissions`](https://r-docs.synapse.org/latest/reference/Evaluation_GetPermissions.md)`(instance, synapse_client=NULL)`:
  Get the user permissions for this evaluation.

- [`synUpdateAcl`](https://r-docs.synapse.org/latest/reference/Evaluation_UpdateAcl.md)`(instance, principal_id=NULL, access_type=NULL, acl=NULL, synapse_client=NULL)`:
  Update the access control list (ACL) for this evaluation.  
    
  You can either:  
  1. Provide a `principal_id` and `access_type` list to update
  permissions for a specific user/team  
  2. Provide a complete ACL named list to update all permissions at
  once  
    
  To remove a principal from the ACL completely, provide an empty list
  for `access_type`.  
    
  The available access types are:  
    
  - "CREATE"  
  - "SUBMIT"  
  - "READ_PRIVATE_SUBMISSION"  
  - "DELETE_SUBMISSION"  
  - "UPDATE_SUBMISSION"  
  - "CHANGE_PERMISSIONS"  
  - "READ"  
  - "DELETE"  
  - "UPDATE"

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Create a new evaluation in a project
    # Create a new evaluation on Synapse by storing an evaluation object with the required fields. If there are any fields missing, an error will be raised.
    library(synapser)
    synLogin()

    evaluation = Evaluation(
        name = "My Challenge Evaluation",
        description = "Evaluation for my data challenge",
        content_source = "syn123456",
        submission_instructions_message = "Submit CSV files only",
        submission_receipt_message = "Thank you for your submission!"
    )
    created = evaluation |> synStore()

## Example 2: Get an evaluation by ID and by name
    library(synapser)
    synLogin()

    # Get an evaluation by ID
    evaluation_by_id = Evaluation(id = "9999999") |> synGet()

    # Get an evaluation by name
    evaluation_by_name = Evaluation(name = "My Challenge Evaluation") |> synGet()

## Example 3: Update an existing evaluation retrieved from Synapse by ID
    # You can use synStore() to create and update evaluations.
    library(synapser)
    synLogin()

    evaluation = synGetAllEvaluations(evaluation_ids = list("9999999"))[[1]]
    evaluation$description = "Updated description for my evaluation"
    updated = evaluation |> synStore()

## Example 4: Retrieve and update the ACL of an evaluation
    library(synapser)
    synLogin()

    evaluation = synGetAllEvaluations(evaluation_ids = list("9999999"))[[1]]
    acl = evaluation |> synGetAcl()

    # Let's grant this team READ and SUBMIT permissions
    team_id = "123456"
    evaluation |> synUpdateAcl(principal_id = team_id, access_type = list("READ", "SUBMIT"))

    # Now let's revoke all permissions from this team
    team_to_revoke_from = "654321"
    evaluation |> synUpdateAcl(principal_id = team_to_revoke_from, access_type = list())

## Example 5: Delete an evaluation
    library(synapser)
    synLogin()

    evaluation = synGetAllEvaluations(evaluation_ids = list("9999999"))[[1]]
    evaluation |> synDelete()
} # }
```
