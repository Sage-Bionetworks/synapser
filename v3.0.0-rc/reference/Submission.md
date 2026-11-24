# Submission

A `Submission` object represents a Synapse Submission, which is created
when a user submits an entity to an evaluation queue.
<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/Submission.html>

## Usage

``` r
Submission(id=NULL, user_id=NULL, submitter_alias=NULL, entity_id=NULL, version_number=NULL, evaluation_id=NULL, evaluation_round_id=NULL, name=NULL, created_on=NULL, team_id=NULL, contributors=list(), submission_status=NULL, entity_bundle_json=NULL, docker_repository_name=NULL, docker_digest=NULL, docker_tag=NULL, etag=NULL)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[character\]) The unique ID of this Submission.

- user_id:

  (Optional\[character\]) The ID of the user that submitted this
  Submission.

- submitter_alias:

  (Optional\[character\]) The name of the user that submitted this
  Submission.

- entity_id:

  (Optional\[character\]) The ID of the entity being submitted.

- version_number:

  (Optional\[integer\]) The version number of the entity at submission.

- evaluation_id:

  (Optional\[character\]) The ID of the Evaluation to which this
  Submission belongs.

- evaluation_round_id:

  (Optional\[character\]) The ID of the EvaluationRound to which this
  was submitted (auto-filled upon creation).

- name:

  (Optional\[character\]) The name of this Submission.

- created_on:

  (Optional\[character\]) The date this Submission was created.

- team_id:

  (Optional\[character\]) The ID of the team that submitted this
  submission (if it's a team submission).

- contributors:

  (list\[character\]) User IDs of team members who contributed to this
  submission (if it's a team submission).

- submission_status:

  (Optional\[named list\]) The status of this Submission.

- entity_bundle_json:

  (Optional\[character\]) The bundled entity information at submission.
  This includes the entity, annotations, file handles, and other
  metadata.

- docker_repository_name:

  (Optional\[character\]) For Docker repositories, the repository name.

- docker_digest:

  (Optional\[character\]) For Docker repositories, the digest of the
  submitted Docker image.

- docker_tag:

  (Optional\[character\]) For Docker repositories, the tag of the
  submitted Docker image.

- etag:

  (Optional\[character\]) The current eTag of the Entity being
  submitted. If not provided, it will be automatically retrieved.

## Value

NULL

## Methods

- `Submission(id=NULL, user_id=NULL, submitter_alias=NULL, entity_id=NULL, version_number=NULL, evaluation_id=NULL, evaluation_round_id=NULL, name=NULL, created_on=NULL, team_id=NULL, contributors=list(), submission_status=NULL, entity_bundle_json=NULL, docker_repository_name=NULL, docker_digest=NULL, docker_tag=NULL, etag=NULL)`:
  Constructor for `Submission`

- [`synCancel`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission_Cancel.md)`(instance, synapse_client=NULL)`:
  Cancel a Submission. Only the user who created the Submission may
  cancel it.

- [`synGetEvaluationSubmissions`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission_GetEvaluationSubmissions.md)`(cls, evaluation_id, status=NULL, synapse_client=NULL)`:
  Retrieves all Submissions for a specified Evaluation queue.

- [`synGetSubmissionCount`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission_GetSubmissionCount.md)`(evaluation_id, synapse_client=NULL)`:
  Gets the number of Submissions for a specified Evaluation queue.

- [`synGetUserSubmissions`](https://r-docs.synapse.org/v3.0.0-rc/reference/Submission_GetUserSubmissions.md)`(cls, evaluation_id, synapse_client=NULL)`:
  Retrieves all user Submissions for a specified Evaluation queue.

## Examples

``` r
if (FALSE) { # \dontrun{
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
    print(sprintf("Created submission with ID: %s", stored_submission$id))

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
    print(sprintf("Found %d of my submissions", length(my_submissions)))

## Example 4: Delete a Submission.
    library(synapser)
    synLogin()

    Submission(id = "9999999") |> synDelete()
    print("Submission deleted successfully")
} # }
```
