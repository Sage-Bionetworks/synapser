%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synUpdateAcl}
\alias{synUpdateAcl}
\docType{methods}
\title{
Evaluation :  update_acl
}
\description{
Update the access control list (ACL) for this evaluation.

You can either: <br>
1. Provide a \code{principal_id} and \code{access_type} list to update permissions for a specific user/team <br>
2. Provide a complete ACL dictionary to update all permissions at once

To remove a principal from the ACL completely, provide an empty list for access_type.

The available access types are:

- 'CREATE'
- 'SUBMIT'
- 'READ_PRIVATE_SUBMISSION'
- 'DELETE_SUBMISSION'
- 'UPDATE_SUBMISSION'
- 'CHANGE_PERMISSIONS'
- 'READ'
- 'DELETE'
- 'UPDATE'
}
\usage{
synUpdateAcl(instance, principal_id=NULL, access_type=NULL, acl=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{principal_id}{(Optional[Union[str, int]]) The Synapse user or team ID to update permissions for.}
\item{access_type}{(Optional[list[str]]) List of permission strings to grant to the principal. If empty, the principal will be removed from the ACL.}
\item{acl}{(Optional[dict]) A dictionary containing the complete ACL data to update. You can retrieve the current ACL using \code{get_acl_async()}. If provided, principal_id and access_type are ignored.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The updated AccessControlList response object as a raw JSON dict.
}
\section{Errors}{
ValueError: If neither (principal_id and access_type) nor acl is provided, or if the ACL object is invalid.
    SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Example 1: Update permissions for a specific principal (user/team)

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def update_evaluation_permissions():
        # Get the evaluation first
        evaluation = await Evaluation(id="9999999").get_async()

        # Update permissions for user with ID 12345
        updated_acl = await evaluation.update_acl_async(
            principal_id="12345",
            access_type=["READ", "SUBMIT"]
        )
        return updated_acl

    updated_acl = asyncio.run(update_evaluation_permissions())

## Example 2: Remove a principal (user/team) from the ACL

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def remove_user_from_acl():
        # Get the evaluation first
        evaluation = await Evaluation(id="9999999").get_async()

        # Remove user with ID 12345 from the ACL by providing an empty list
        updated_acl = await evaluation.update_acl_async(
            principal_id="12345",
            access_type=[]
        )
        return updated_acl

    updated_acl = asyncio.run(remove_user_from_acl())

## Example 3: Update the entire ACL manually

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def update_evaluation_acl():
        # Get the evaluation first
        evaluation = await Evaluation(id="9999999").get_async()

        # Get the current ACL
        acl = await evaluation.get_acl_async()

        # Modify the ACL manually
        acl["resourceAccess"].append({
            "principalId": 12345,
            "accessType": ["READ", "SUBMIT"]
        })

        # Update with the modified ACL
        updated_acl = await evaluation.update_acl_async(acl=acl)
        return updated_acl

    updated_acl = asyncio.run(update_evaluation_acl())
}
}
\keyword{Evaluation}
