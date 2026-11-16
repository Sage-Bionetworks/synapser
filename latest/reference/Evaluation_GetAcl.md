# Evaluation : get_acl

Get the access control list (ACL) governing this evaluation.

## Usage

``` r
synGetAcl(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Evaluation) The Evaluation instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The
[AccessControlList](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html)
response object as a named list.

## Errors

\- An error is raised if the evaluation's `id` is not set.  
- An error is also raised if the service rejects the request or an HTTP
error occurs.

## Note

Unlike `synGetAcl()` on an entity such as a
[`Folder`](https://r-docs.synapse.org/latest/reference/Folder.md), this
takes no `principal_id` or `check_benefactor` argument, and passing
either one is an error. It returns the ACL for every principal on the
evaluation, under `resourceAccess`.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the ACL for an evaluation
    library(synapser)
    synLogin()

    PROJECT_ID = "syn123456"  # replace with your project ID

    # Store a new evaluation in the project first
    evaluation = Evaluation(
        name = "My Challenge Evaluation",
        description = "Evaluation for my data challenge",
        content_source = PROJECT_ID,
        submission_instructions_message = "Submit CSV files only",
        submission_receipt_message = "Thank you for your submission!"
    ) |> synStore()

    # Get the evaluation back from Synapse
    evaluations = synGetEvaluationsByProject(
        project_id = PROJECT_ID,
        evaluation_ids = list(evaluation$id)
    )
    evaluation = evaluations[[1]]

    # Get the ACL for the evaluation
    acl = evaluation |> synGetAcl()
    acl
} # }
```
