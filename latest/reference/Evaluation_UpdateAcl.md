# Evaluation : update_acl

Update the access control list (ACL) for this evaluation.

You can either:  
1. Provide a `principal_id` and `access_type` list to update permissions
for a specific user/team  
2. Provide a complete ACL named list to update all permissions at once

To remove a principal from the ACL completely, provide an empty list for
`access_type`.

The available access types are:

\- "CREATE"  
- "SUBMIT"  
- "READ_PRIVATE_SUBMISSION"  
- "DELETE_SUBMISSION"  
- "UPDATE_SUBMISSION"  
- "CHANGE_PERMISSIONS"  
- "READ"  
- "DELETE"  
- "UPDATE"

## Usage

``` r
synUpdateAcl(instance, principal_id=NULL, access_type=NULL, acl=NULL, synapse_client=NULL)
```

## Arguments

- instance:

  (Evaluation) The Evaluation instance to operate on.

- principal_id:

  (Optional\[Union\[str, int\]\]) The Synapse user or team ID to update
  permissions for.

- access_type:

  (Optional\[list\[str\]\]) List of permission strings to grant to the
  principal. If empty, the principal will be removed from the ACL.

- acl:

  (Optional\[named list\]) A named list containing the complete ACL data
  to update. You can retrieve the current ACL using
  [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAcl.md).
  If provided, `principal_id` and `access_type` are ignored.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The updated
[AccessControlList](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html)
response object as a named list.

## Errors

\- An error is raised if neither (`principal_id` and `access_type`) nor
`acl` is provided, or if the ACL object is invalid.  
- An error is also raised if the service rejects the request or an HTTP
error occurs.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Update permissions for a specific principal (user/team)
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

    # Update permissions for user with ID 12345
    updated_acl = evaluation |> synUpdateAcl(
        principal_id = "12345",
        access_type = list("READ", "SUBMIT")
    )
    updated_acl

## Example 2: Remove a principal (user/team) from the ACL
    # Using the evaluation stored in Example 1

    # Remove user with ID 12345 from the ACL by providing an empty list
    updated_acl = evaluation |> synUpdateAcl(
        principal_id = "12345",
        access_type = list()
    )
    updated_acl

## Example 3: Update the entire ACL manually
    # Using the evaluation stored in Example 1

    # Get the current ACL
    acl = evaluation |> synGetAcl()

    # Modify the ACL manually
    acl$resourceAccess = c(acl$resourceAccess, list(list(
        principalId = 12345L,
        accessType = list("READ", "SUBMIT")
    )))

    # Update with the modified ACL
    updated_acl = evaluation |> synUpdateAcl(acl = acl)
    updated_acl
} # }
```
