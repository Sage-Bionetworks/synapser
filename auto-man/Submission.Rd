%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Submission}
\alias{Submission}
\docType{class}
\title{
Submission
}
\format{An S3-style class object.}
\description{
A \code{Submission} object represents a Synapse Submission, which is created when a user
submits an entity to an evaluation queue.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/Submission.html>
}
\usage{
Submission(id=NULL, user_id=NULL, submitter_alias=NULL, entity_id=NULL, version_number=NULL, evaluation_id=NULL, evaluation_round_id=NULL, name=NULL, created_on=NULL, team_id=NULL, contributors=list(), submission_status=NULL, entity_bundle_json=NULL, docker_repository_name=NULL, docker_digest=NULL, docker_tag=NULL, etag=NULL)
}
\arguments{
\item{id}{(Optional[str]) The unique ID of this Submission.}
\item{user_id}{(Optional[str]) The ID of the user that submitted this Submission.}
\item{submitter_alias}{(Optional[str]) The name of the user that submitted this Submission.}
\item{entity_id}{(Optional[str]) The ID of the entity being submitted.}
\item{version_number}{(Optional[int]) The version number of the entity at submission.}
\item{evaluation_id}{(Optional[str]) The ID of the Evaluation to which this Submission belongs.}
\item{evaluation_round_id}{(Optional[str]) The ID of the EvaluationRound to which this was submitted (auto-filled upon creation).}
\item{name}{(Optional[str]) The name of this Submission.}
\item{created_on}{(Optional[str]) The date this Submission was created.}
\item{team_id}{(Optional[str]) The ID of the team that submitted this submission (if it's a team submission).}
\item{contributors}{(list[str]) User IDs of team members who contributed to this submission (if it's a team submission).}
\item{submission_status}{(Optional[dict]) The status of this Submission.}
\item{entity_bundle_json}{(Optional[str]) The bundled entity information at submission. This includes the entity, annotations, file handles, and other metadata.}
\item{docker_repository_name}{(Optional[str]) For Docker repositories, the repository name.}
\item{docker_digest}{(Optional[str]) For Docker repositories, the digest of the submitted Docker image.}
\item{docker_tag}{}
\item{etag}{}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Retrieve a Submission.
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    submission = Submission(id="syn123456").get()
    print(submission)

## Example 2: Create and store a new Submission.
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    # Create a new submission
    submission = Submission(
        entity_id="syn123456",
        evaluation_id="9999999",
        name="My Submission"
    )

    # Store the submission
    stored_submission = submission.store()
    print(f"Created submission with ID: {stored_submission.id}")

## Example 3: Get all submissions for a user.
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    # Get submissions for the current user
    my_submissions = list(Submission.get_user_submissions(
        evaluation_id="9999999"
    ))
    print(f"Found {len(my_submissions)} of my submissions")
}
}
\section{Methods}{
\itemize{
\item \code{Submission(id=NULL, user_id=NULL, submitter_alias=NULL, entity_id=NULL, version_number=NULL, evaluation_id=NULL, evaluation_round_id=NULL, name=NULL, created_on=NULL, team_id=NULL, contributors=list(), submission_status=NULL, entity_bundle_json=NULL, docker_repository_name=NULL, docker_digest=NULL, docker_tag=NULL, etag=NULL)}: Constructor for \code{\link{Submission}}
\item \code{cancel(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{get_submission_count(evaluation_id, synapse_client=NULL)}: Gets the number of Submissions for a specified Evaluation queue, optionally filtered by submission status.
}
}

