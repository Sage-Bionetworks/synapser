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
\url{https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/Submission.html}
}
\usage{
Submission(id=NULL, user_id=NULL, submitter_alias=NULL, entity_id=NULL, version_number=NULL, evaluation_id=NULL, evaluation_round_id=NULL, name=NULL, created_on=NULL, team_id=NULL, contributors=list(), submission_status=NULL, entity_bundle_json=NULL, docker_repository_name=NULL, docker_digest=NULL, docker_tag=NULL, etag=NULL)
}
\arguments{
\item{id}{(Optional[character]) The unique ID of this Submission.}
\item{user_id}{(Optional[character]) The ID of the user that submitted this Submission.}
\item{submitter_alias}{(Optional[character]) The name of the user that submitted this Submission.}
\item{entity_id}{(Optional[character]) The ID of the entity being submitted.}
\item{version_number}{(Optional[integer]) The version number of the entity at submission.}
\item{evaluation_id}{(Optional[character]) The ID of the Evaluation to which this Submission belongs.}
\item{evaluation_round_id}{(Optional[character]) The ID of the EvaluationRound to which this was submitted (auto-filled upon creation).}
\item{name}{(Optional[character]) The name of this Submission.}
\item{created_on}{(Optional[character]) The date this Submission was created.}
\item{team_id}{(Optional[character]) The ID of the team that submitted this submission (if it's a team submission).}
\item{contributors}{(list[character]) User IDs of team members who contributed to this submission (if it's a team submission).}
\item{submission_status}{(Optional[named list]) The status of this Submission.}
\item{entity_bundle_json}{(Optional[character]) The bundled entity information at submission. This includes the entity, annotations, file handles, and other metadata.}
\item{docker_repository_name}{(Optional[character]) For Docker repositories, the repository name.}
\item{docker_digest}{(Optional[character]) For Docker repositories, the digest of the submitted Docker image.}
\item{docker_tag}{(Optional[character]) For Docker repositories, the tag of the submitted Docker image.}
\item{etag}{(Optional[character]) The current eTag of the Entity being submitted. If not provided, it will be automatically retrieved.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Create and store a new Submission.
    library(synapser)
    synLogin()

    # Create a new submission
    submission = Submission(
        entity_id = "syn123456",
        evaluation_id = "9999999",
        name = "My Submission"
    )

    # Store the submission
    stored_submission = submission |> synStore()
    print(sprintf("Created submission with ID: \%s", stored_submission$id))

## Example 2: Retrieve a Submission.
    library(synapser)
    synLogin()

    submission = Submission(id = "9999999") |> synGet()
    print(submission)

## Example 3: Get all submissions for a user.
    library(synapser)
    synLogin()

    # Get submissions for the current user
    my_submissions = as.list(Submission() |> synGetUserSubmissions(
        evaluation_id = "9999999"
    ))
    print(sprintf("Found \%d of my submissions", length(my_submissions)))

## Example 4: Delete a Submission.
    library(synapser)
    synLogin()

    Submission(id = "9999999") |> synDelete()
    print("Submission deleted successfully")
}
}
\section{Methods}{
\itemize{
\item \code{Submission(id=NULL, user_id=NULL, submitter_alias=NULL, entity_id=NULL, version_number=NULL, evaluation_id=NULL, evaluation_round_id=NULL, name=NULL, created_on=NULL, team_id=NULL, contributors=list(), submission_status=NULL, entity_bundle_json=NULL, docker_repository_name=NULL, docker_digest=NULL, docker_tag=NULL, etag=NULL)}: Constructor for \code{\link{Submission}}
\item \code{\link[=Submission_synCancel]{synCancel}(instance, synapse_client=NULL)}: Cancel a Submission. Only the user who created the Submission may cancel it.
\item \code{\link[=Submission_synGetEvaluationSubmissions]{synGetEvaluationSubmissions}(cls, evaluation_id, status=NULL, synapse_client=NULL)}: Retrieves all Submissions for a specified Evaluation queue.
\item \code{\link[=Submission_synGetSubmissionCount]{synGetSubmissionCount}(evaluation_id, synapse_client=NULL)}: Gets the number of Submissions for a specified Evaluation queue.
\item \code{\link[=Submission_synGetUserSubmissions]{synGetUserSubmissions}(cls, evaluation_id, synapse_client=NULL)}: Retrieves all user Submissions for a specified Evaluation queue.
}
}

