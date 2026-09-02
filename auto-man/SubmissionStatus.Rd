%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SubmissionStatus}
\alias{SubmissionStatus}
\docType{class}
\title{
SubmissionStatus
}
\format{An S3-style class object.}
\description{
A SubmissionStatus is a secondary, mutable object associated with a Submission.
This object should be used to contain scoring data about the Submission.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatus.html>
}
\usage{
SubmissionStatus(id=NULL, etag=NULL, modified_on=NULL, status=NULL, score=NULL, report=NULL, annotations=list(), submission_annotations=list(), private_status_annotations=TRUE, entity_id=NULL, version_number=NULL, status_version=NULL, can_cancel=FALSE, cancel_requested=FALSE, _last_persistent_instance=NULL)
}
\arguments{
\item{id}{(Optional[str]) The unique, immutable Synapse ID of the Submission.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. The eTag changes every time a SubmissionStatus is updated; it is used to detect when a client's copy of a SubmissionStatus is out-of-date.}
\item{modified_on}{(Optional[str]) The date on which this SubmissionStatus was last modified.}
\item{status}{(Optional[str]) The possible states of a Synapse Submission (e.g., RECEIVED, VALIDATED, SCORED).}
\item{score}{(Optional[float]) This field is deprecated and should not be used. Use the 'submission_annotations' field instead.}
\item{report}{(Optional[str]) This field is deprecated and should not be used. Use the 'submission_annotations' field instead.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Primary container object for Annotations on a Synapse object. These annotations use the legacy format and do not show up in a submission view. The visibility is controlled by private_status_annotations.}
\item{submission_annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Submission Annotations are additional key-value pair metadata that are associated with an object. These annotations use the modern nested format and show up in a submission view.}
\item{private_status_annotations}{(Optional[bool]) Indicates whether the annotations (not to be confused with submission annotations) are private (True) or public (False). Default is True. This controls the visibility of the 'annotations' field.}
\item{entity_id}{(Optional[str]) The Synapse ID of the Entity in this Submission.}
\item{version_number}{(Optional[int]) The version number of the Entity in this Submission.}
\item{status_version}{(Optional[int]) A version of the status, auto-generated and auto-incremented by the system and read-only to the client.}
\item{can_cancel}{(Optional[bool]) Can this submission be cancelled? By default, this will be set to False. Users can read this value. Only the queue's scoring application can change this value.}
\item{cancel_requested}{(Optional[bool]) Has user requested to cancel this submission? By default, this will be set to False. Submission owner can read and request to change this value.}
\item{_last_persistent_instance}{}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Retrieve and update a SubmissionStatus.
    # This example demonstrates the basic workflow of retrieving an existing submission status, updating its fields, and storing the changes back to Synapse.
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    # Get a submission status
    status = SubmissionStatus(id="9999999").get()

    # Update the status
    status.status = "SCORED"
    status.submission_annotations = {"score": [85.5], "feedback": ["Good work!"]}
    status = status.store()
    print(status)

## Example 2: Get all submission statuses for an evaluation.
    # Retrieve multiple submission statuses for an evaluation queue with optional filtering.
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    # Get all RECEIVED statuses for an evaluation
    statuses = SubmissionStatus.get_all_submission_statuses(
        evaluation_id="9999999",
        status="RECEIVED",
        limit=100
    )

    print(f"Found {len(statuses)} submission statuses")
    for status in statuses:
        print(f"Status ID: {status.id}, Status: {status.status}")

## Example 3: Batch update multiple submission statuses.
    # Efficiently update multiple submission statuses in a single operation.
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    # Retrieve statuses to update
    statuses = SubmissionStatus.get_all_submission_statuses(
        evaluation_id="9999999",
        status="RECEIVED"
    )

    # Update each status
    for status in statuses:
        status.status = "SCORED"
        status.submission_annotations = {
            "validation_score": 95.0,
            "comments": "Passed validation"
        }

    # Batch update all statuses
    response = SubmissionStatus.batch_update_submission_statuses(
        evaluation_id="9999999",
        statuses=statuses
    )
    print(f"Batch update completed: {response}")
}
}
\section{Methods}{
\itemize{
\item \code{SubmissionStatus(id=NULL, etag=NULL, modified_on=NULL, status=NULL, score=NULL, report=NULL, annotations=list(), submission_annotations=list(), private_status_annotations=TRUE, entity_id=NULL, version_number=NULL, status_version=NULL, can_cancel=FALSE, cancel_requested=FALSE, _last_persistent_instance=NULL)}: Constructor for \code{\link{SubmissionStatus}}
\item \code{batch_update_submission_statuses(evaluation_id, statuses, is_first_batch=TRUE, is_last_batch=TRUE, batch_token=NULL, synapse_client=NULL)}: Update multiple SubmissionStatuses. The maximum batch size is 500.
\item \code{delete_permissions(include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL, _benefactor_tracker=NULL)}: Delete the entire Access Control List (ACL) for a given Entity. This is not\cr
scoped to a specific user or group, but rather removes all permissions\cr
associated with the Entity. After this operation, the Entity will inherit\cr
permissions from its benefactor, which is typically its parent entity or\cr
the Project it belongs to.\cr
\cr
In order to remove permissions for a specific user or group, you\cr
should use the \code{set_permissions_async} method with the \code{access_type} set to\cr
an empty list.\cr
\cr
By default, Entities such as FileEntity and Folder inherit their permission from\cr
their containing Project. For such Entities the Project is the Entity's 'benefactor'.\cr
This permission inheritance can be overridden by creating an ACL for the Entity.\cr
When this occurs the Entity becomes its own benefactor and all permission are\cr
determined by its own ACL.\cr
\cr
If the ACL of an Entity is deleted, then its benefactor will automatically be set\cr
to its parent's benefactor.\cr
\cr
**Special notice for Projects:** The ACL for a Project cannot be deleted, you\cr
must individually update or revoke the permissions for each user or group.
\item \code{get_acl(principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]\cr
that a user or group has on an Entity.
\item \code{get_all_submission_statuses(evaluation_id, status=NULL, limit=10L, offset=0L, synapse_client=NULL)}: Gets a collection of SubmissionStatuses to a specified Evaluation.
\item \code{get_permissions(synapse_client=NULL)}: Get the [permissions][synapseclient.core.models.permission.Permissions]\cr
that the caller has on an Entity.
\item \code{list_acl(recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL, _progress_bar=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.\cr
\cr
This function returns the local sharing settings for the entity and optionally\cr
its children. It provides a mapping of all ACLs for the given container/entity.\cr
\cr
**Important Note:** This function returns the LOCAL sharing settings only, not\cr
the effective permissions that each Synapse User ID/Team has on the entities.\cr
More permissive permissions could be granted via a Team that the user has access\cr
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{set_permissions(principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.\cr
An Entity may have its own ACL or inherit its ACL from a benefactor.
}
}

