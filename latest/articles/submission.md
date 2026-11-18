# Submissions, SubmissionStatuses, SubmissionBundles

## What are Submissions?

In Synapse, a Submission is your entry to a challenge or evaluation
queue. When you participate in a computational challenge or
collaborative project, you submit your work (such as predictions,
models, or analysis results) as a Submission to be evaluated and scored.

## Key Concepts

Before working with Submissions, it’s helpful to understand how they fit
into Synapse:

- **Entity**: Your actual work stored in Synapse (like a File containing
  predictions or a Docker image with your model)
- **Evaluation**: A queue that accepts and organizes submissions for a
  specific challenge or project
- **Submission**: The object associated with submitting your Entity to
  an Evaluation queue, creating a record that can be tracked and scored

## How Submissions Work

When you submit an Entity to an Evaluation:

- The Submission creates an immutable record linking your Entity to that
  Evaluation
- The Evaluation owns this Submission record (not you as the submitter)
- Organizers can add scores and feedback through a SubmissionStatus
  object
- You can track your Submissions and view their statuses

## Related Objects

synapser provides three object types for working with Submissions:

- **Submission**: Represents your entry in an Evaluation queue
- **SubmissionStatus**: Tracks scoring information and feedback for a
  Submission
- **SubmissionBundle**: Combines a Submission and its SubmissionStatus
  for convenient access

## What You’ll Learn

This tutorial covers two perspectives:

1.  **Participating in challenges**: Making and tracking your
    submissions
2.  **Organizing challenges**: Scoring and managing submissions from
    participants

## Tutorial Purpose

In this tutorial:

As a participant of a Synapse challenge, you will

1.  Make a submission to an existing evaluation queue on Synapse
2.  Fetch your existing submission
3.  Count your submissions
4.  Fetch all of your submissions from an existing evaluation queue on
    Synapse
5.  Check the status of your submission
6.  Cancel your submission

As an organizer of a Synapse challenge, you will

1.  Annotate a submission to score it
2.  Batch-update submission statuses
3.  Fetch the submission bundles for an evaluation queue
4.  Allow cancellation of submissions
5.  Delete submissions

## Prerequisites

- You have an existing
  [Evaluation](https://r-docs.synapse.org/latest/articles/evaluation.md)
  on Synapse to work from
- You have an existing entity with which to make a submission (can be a
  [File](https://r-docs.synapse.org/latest/articles/file.md) or Docker
  Repository)
- You have the correct permissions on the Evaluation queue for your
  desired tutorial section (participant or organizer)

## 1. Participating in a Synapse challenge

### Initial setup

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`# REQUIRED: Set these to your actual Synapse IDs`\
`# Do NOT leave these as NULL - the script will not work properly`\
`EVALUATION_ID`` ``<-`` ``NULL`` ``# Replace with the evaluation queue ID you submitted to`\
`ENTITY_ID`` ``<-`` ``NULL`` ``# Replace with the entity ID you want to submit`\
\
[`stopifnot`](https://rdrr.io/r/base/stopifnot.html)`(`\
`  ``"EVALUATION_ID must be set to the evaluation queue ID"`` ``=`` ``!`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``EVALUATION_ID``)``,`\
`  ``"ENTITY_ID must be set to the entity ID you want to submit"`` ``=`` ``!`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``ENTITY_ID``)`\
`)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Working with Evaluation: %s"``, ``EVALUATION_ID``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Submitting Entity: %s"``, ``ENTITY_ID``)``)`

### 1. Make a submission to an existing evaluation queue on Synapse

\
`# Create a new Submission object`\
`submission`` ``<-`` `[`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)`(`\
`  entity_id ``=`` ``ENTITY_ID``, evaluation_id ``=`` ``EVALUATION_ID``, name ``=`` ``"My Tutorial Submission"`\
`)`\
\
`# Submit the entity to the evaluation queue`\
`submission`` ``<-`` ``submission`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(``"Submission created successfully!"``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Submission ID: %s"``, ``submission``$``id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Submitted Entity: %s"``, ``submission``$``entity_id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Evaluation: %s"``, ``submission``$``evaluation_id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Submission Name: %s"``, ``submission``$``name``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Created On: %s"``, ``submission``$``created_on``)``)`\
\
`# Store the submission ID for later use`\
`submission_id`` ``<-`` ``submission``$``id`

### 2. Fetch your existing submission

\
`# Retrieve the submission we just created`\
`retrieved_submission`` ``<-`` `[`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)`(``id ``=`` ``submission_id``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(``"Retrieved submission:"``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  ID: %s"``, ``retrieved_submission``$``id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Name: %s"``, ``retrieved_submission``$``name``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Entity ID: %s"``, ``retrieved_submission``$``entity_id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Submitter: %s"``, ``retrieved_submission``$``submitter_alias``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Created On: %s"``, ``retrieved_submission``$``created_on``)``)`

### 3. Count your submissions

\
`# Get the total count of submissions for this evaluation`\
`submission_count`` ``<-`` ``synGetSubmissionCount``(``evaluation_id ``=`` ``EVALUATION_ID``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(``submission_count``)`

### 4. Fetch all of your submissions from an existing evaluation queue on Synapse

\
`# Get all of your submissions for this evaluation`\
`user_submissions`` ``<-`` `[`as.list`](https://rdrr.io/r/base/list.html)`(`[`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)`(``)`` ``|>`` ``synGetUserSubmissions``(``evaluation_id ``=`` ``EVALUATION_ID``)``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Found %d submissions from the current user:"``, `[`length`](https://rdrr.io/r/base/length.html)`(``user_submissions``)``)``)`\
`for`` ``(``i`` ``in`` `[`seq_along`](https://rdrr.io/r/base/seq.html)`(``user_submissions``)``)`` ``{`\
`  ``sub`` ``<-`` ``user_submissions``[[``i``]``]`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  %d. ID: %s, Name: %s, Created: %s"``, ``i``, ``sub``$``id``, ``sub``$``name``, ``sub``$``created_on``)``)`\
`}`

### 5. Check the status of your submission

\
`# Fetch the status of our submission`\
`status`` ``<-`` `[`SubmissionStatus`](https://r-docs.synapse.org/latest/reference/SubmissionStatus.md)`(``id ``=`` ``submission_id``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(``"Submission status details:"``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Status: %s"``, ``status``$``status``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Modified On: %s"``, ``status``$``modified_on``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Can Cancel: %s"``, ``status``$``can_cancel``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Cancel Requested: %s"``, ``status``$``cancel_requested``)``)`\
\
`# Check if there are any submission annotations (scores, feedback, etc.)`\
`annotations`` ``<-`` ``status``$``submission_annotations`\
`if`` ``(`[`length`](https://rdrr.io/r/base/length.html)`(``annotations``)`` ``>`` ``0``)`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(``"  Submission Annotations:"``)`\
`  ``for`` ``(``key`` ``in`` `[`names`](https://rdrr.io/r/base/names.html)`(``annotations``)``)`` ``{`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"    %s: %s"``, ``key``, `[`paste`](https://rdrr.io/r/base/paste.html)`(`[`unlist`](https://rdrr.io/r/base/unlist.html)`(``annotations``[[``key``]``]``)``, collapse ``=`` ``", "``)``)``)`\
`  ``}`\
`}`` ``else`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(``"  No submission annotations available"``)`\
`}`

### 6. Cancel your submission

Only cancel a submission if it allows it. The cancellation code is
commented out by default; uncomment it if you want to test this
functionality.

\
`# cancelled_submission = submission |> synCancel()`\
`# print(sprintf("Submission %s has been requested for cancellation", cancelled_submission$id))`\
`#`\
`# # Check the updated status`\
`# updated_status = SubmissionStatus(id = submission_id) |> synGet()`\
`# print(sprintf("Cancel requested: %s", updated_status$cancel_requested))`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Your submission ID %s is ready for evaluation."``, ``submission_id``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``"Check back later to see if the organizers have scored your submission."``)`

## 2. Organizing a Synapse challenge

### Initial setup

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`# REQUIRED: Set these to your actual Synapse IDs`\
`# Do NOT leave these as NULL - the script will not work properly`\
`EVALUATION_ID`` ``<-`` ``NULL`` ``# Replace with the evaluation queue ID you submitted to`\
`SUBMISSION_ID`` ``<-`` ``NULL`` ``# Replace with the ID of a submission you made`\
\
[`stopifnot`](https://rdrr.io/r/base/stopifnot.html)`(`\
`  ``"EVALUATION_ID must be set to the evaluation queue ID"`` ``=`` ``!`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``EVALUATION_ID``)``,`\
`  ``"SUBMISSION_ID must be set to the ID of a submission you made"`` ``=`` ``!`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``SUBMISSION_ID``)`\
`)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Working with Evaluation: %s"``, ``EVALUATION_ID``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Working with Submission: %s"``, ``SUBMISSION_ID``)``)`

### 1. Annotate a submission to score it

\
`# First, get the submission status`\
`status`` ``<-`` `[`SubmissionStatus`](https://r-docs.synapse.org/latest/reference/SubmissionStatus.md)`(``id ``=`` ``SUBMISSION_ID``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Retrieved submission status for submission %s"``, ``SUBMISSION_ID``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Current status: %s"``, ``status``$``status``)``)`\
\
`# Update the submission status with scoring information`\
`status``$``status`` ``<-`` ``"SCORED"`\
`status``$``submission_annotations`` ``<-`` `[`list`](https://rdrr.io/r/base/list.html)`(`\
`  accuracy ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``0.85``)``,`\
`  precision ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``0.82``)``,`\
`  feedback ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"Good performance!"``)``,`\
`  validation_errors ``=`` ``"None detected"``,`\
`  score_errors ``=`` ``"None detected"`\
`)`\
\
`# Store the updated status`\
`updated_status`` ``<-`` ``status`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``"Successfully scored submission!"``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Status: %s"``, ``updated_status``$``status``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``"Annotations added:"``)`\
`for`` ``(``key`` ``in`` `[`names`](https://rdrr.io/r/base/names.html)`(``updated_status``$``submission_annotations``)``)`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  %s: %s"``, ``key``, `[`paste`](https://rdrr.io/r/base/paste.html)`(`[`unlist`](https://rdrr.io/r/base/unlist.html)`(``updated_status``$``submission_annotations``[[``key``]``]``)``, collapse ``=`` ``", "``)``)``)`\
`}`

### 2. Batch-update submission statuses

\
`# First, get all submission statuses that need updating`\
`statuses_to_update`` ``<-`` ``synGetAllSubmissionStatuses``(`\
`  evaluation_id ``=`` ``EVALUATION_ID``,`\
`  status ``=`` ``"RECEIVED"`` ``# Get submissions that haven't been scored yet`\
`)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Found %d submissions to batch update"``, `[`length`](https://rdrr.io/r/base/length.html)`(``statuses_to_update``)``)``)`\
\
`if`` ``(`[`length`](https://rdrr.io/r/base/length.html)`(``statuses_to_update``)`` ``>`` ``0``)`` ``{`\
`  ``# Update each status with validation information`\
`  ``for`` ``(``i`` ``in`` `[`seq_along`](https://rdrr.io/r/base/seq.html)`(``statuses_to_update``)``)`` ``{`\
`    ``status`` ``<-`` ``statuses_to_update``[[``i``]``]`\
`    ``status``$``status`` ``<-`` ``"VALIDATED"`\
`    ``status``$``submission_annotations`` ``<-`` `[`list`](https://rdrr.io/r/base/list.html)`(`\
`      validation_status ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"PASSED"``)``,`\
`      validation_timestamp ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"2024-11-24T10:30:00Z"``)``,`\
`      batch_number ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``i``)``,`\
`      validator ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"automated_system"``)`\
`    ``)`\
`  ``}`\
\
`  ``# Perform batch update`\
`  ``batch_response`` ``<-`` ``synBatchUpdateSubmissionStatuses``(`\
`    evaluation_id ``=`` ``EVALUATION_ID``,`\
`    statuses ``=`` ``statuses_to_update``,`\
`    is_first_batch ``=`` ``TRUE``,`\
`    is_last_batch ``=`` ``TRUE`\
`  ``)`\
\
`  `[`print`](https://rdrr.io/r/base/print.html)`(``"Batch update completed successfully!"``)`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(``batch_response``)`\
`}`` ``else`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(``"No submissions found with 'RECEIVED' status to update"``)`\
`}`

### 3. Fetch the submission bundles for an evaluation queue

\
`# Get all scored submission bundles for the evaluation`\
[`print`](https://rdrr.io/r/base/print.html)`(``"Fetching all submission bundles for the evaluation..."``)`\
\
`bundles`` ``<-`` `[`as.list`](https://rdrr.io/r/base/list.html)`(`[`SubmissionBundle`](https://r-docs.synapse.org/latest/reference/SubmissionBundle.md)`(``)`` ``|>`` ``synGetEvaluationSubmissionBundles``(`\
`  evaluation_id ``=`` ``EVALUATION_ID``,`\
`  status ``=`` ``"SCORED"`` ``# Only get scored submissions`\
`)``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Found %d scored submission bundles"``, `[`length`](https://rdrr.io/r/base/length.html)`(``bundles``)``)``)`\
\
`first_bundles`` ``<-`` `[`head`](https://rdrr.io/r/utils/head.html)`(``bundles``, ``5``)`` ``# Show first 5`\
`for`` ``(``i`` ``in`` `[`seq_along`](https://rdrr.io/r/base/seq.html)`(``first_bundles``)``)`` ``{`\
`  ``submission`` ``<-`` ``first_bundles``[[``i``]``]``$``submission`\
`  ``status`` ``<-`` ``first_bundles``[[``i``]``]``$``submission_status`\
\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Bundle %d:"``, ``i``)``)`\
`  ``if`` ``(``!`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``submission``)``)`` ``{`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Submission ID: %s"``, ``submission``$``id``)``)`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Submitter: %s"``, ``submission``$``submitter_alias``)``)`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Entity ID: %s"``, ``submission``$``entity_id``)``)`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Created: %s"``, ``submission``$``created_on``)``)`\
`  ``}`\
\
`  ``if`` ``(``!`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``status``)``)`` ``{`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Status: %s"``, ``status``$``status``)``)`\
`    `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Modified: %s"``, ``status``$``modified_on``)``)`\
`    ``annotations`` ``<-`` ``status``$``submission_annotations`\
`    ``if`` ``(`[`length`](https://rdrr.io/r/base/length.html)`(``annotations``)`` ``>`` ``0``)`` ``{`\
`      `[`print`](https://rdrr.io/r/base/print.html)`(``"  Scores:"``)`\
`      ``for`` ``(``key`` ``in`` `[`names`](https://rdrr.io/r/base/names.html)`(``annotations``)``)`` ``{`\
`        ``if`` ``(``key`` `[`%in%`](https://rdrr.io/r/base/match.html)` `[`c`](https://rdrr.io/r/base/c.html)`(``"accuracy"``, ``"f1_score"``, ``"precision"``, ``"recall"``)``)`` ``{`\
`          `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"    %s: %s"``, ``key``, `[`paste`](https://rdrr.io/r/base/paste.html)`(`[`unlist`](https://rdrr.io/r/base/unlist.html)`(``annotations``[[``key``]``]``)``, collapse ``=`` ``", "``)``)``)`\
`        ``}`\
`      ``}`\
`    ``}`\
`  ``}`\
`}`

### 4. Allow cancellation of submissions

\
`# First, check if any submissions have requested cancellation`\
`all_statuses`` ``<-`` ``synGetAllSubmissionStatuses``(``evaluation_id ``=`` ``EVALUATION_ID``)`\
\
`cancellation_requests`` ``<-`` `[`Filter`](https://rdrr.io/r/base/funprog.html)`(``function``(``status``)`` `[`isTRUE`](https://rdrr.io/r/base/Logic.html)`(``status``$``cancel_requested``)``, ``all_statuses``)`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Found %d submissions with cancellation requests"``, `[`length`](https://rdrr.io/r/base/length.html)`(``cancellation_requests``)``)``)`\
\
`# Process cancellation requests`\
`for`` ``(``status`` ``in`` ``cancellation_requests``)`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Processing cancellation request for submission %s"``, ``status``$``id``)``)`\
\
`  ``# Update to allow cancellation (organizer decision)`\
`  ``status``$``can_cancel`` ``<-`` ``TRUE`\
`  ``status``$``status`` ``<-`` ``"CLOSED"`\
`  ``# submission_annotations comes back as an R copy, so update the copy`\
`  ``# (adding or overwriting these keys) and assign it back`\
`  ``annotations`` ``<-`` `[`as.list`](https://rdrr.io/r/base/list.html)`(``status``$``submission_annotations``)`\
`  ``annotations``[`[`c`](https://rdrr.io/r/base/c.html)`(``"cancellation_reason"``, ``"cancelled_by"``, ``"cancellation_date"``)``]`` ``<-`` `[`list`](https://rdrr.io/r/base/list.html)`(`\
`    `[`list`](https://rdrr.io/r/base/list.html)`(``"User requested cancellation"``)``,`\
`    `[`list`](https://rdrr.io/r/base/list.html)`(``"organizer"``)``,`\
`    `[`list`](https://rdrr.io/r/base/list.html)`(``"2024-11-24"``)`\
`  ``)`\
`  ``status``$``submission_annotations`` ``<-`` ``annotations`\
\
`  ``# Store the update`\
`  ``updated_status`` ``<-`` ``status`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"  Approved cancellation for submission %s"``, ``updated_status``$``id``)``)`\
`}`\
\
`# Example: Proactively allow cancellation for a specific submission`\
[`print`](https://rdrr.io/r/base/print.html)`(``"Enabling cancellation for a specific submission..."``)`\
`target_status`` ``<-`` `[`SubmissionStatus`](https://r-docs.synapse.org/latest/reference/SubmissionStatus.md)`(``id ``=`` ``SUBMISSION_ID``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
`target_status``$``can_cancel`` ``<-`` ``TRUE`\
`target_status`` ``<-`` ``target_status`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Cancellation enabled for submission %s"``, ``SUBMISSION_ID``)``)`

### 5. Delete submissions

Find the submissions whose submitters have requested cancellation, and
delete them. The deletion code is commented out by default; uncomment it
if you want to test this functionality.

\
`# Get all submission statuses to check for cancellation requests`\
`all_statuses`` ``<-`` ``synGetAllSubmissionStatuses``(``evaluation_id ``=`` ``EVALUATION_ID``)`\
\
`# Find submissions that have been requested for cancellation`\
`submissions_to_delete`` ``<-`` `[`list`](https://rdrr.io/r/base/list.html)`(``)`\
`for`` ``(``status`` ``in`` ``all_statuses``)`` ``{`\
`  ``if`` ``(`[`isTRUE`](https://rdrr.io/r/base/Logic.html)`(``status``$``cancel_requested``)``)`` ``{`\
`    ``submissions_to_delete`` ``<-`` `[`append`](https://rdrr.io/r/base/append.html)`(``submissions_to_delete``, ``status``$``id``)`\
`  ``}`\
`}`\
\
[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Found %d submissions with cancellation requests"``, `[`length`](https://rdrr.io/r/base/length.html)`(``submissions_to_delete``)``)``)`\
\
`# Delete each submission that was requested for cancellation`\
`for`` ``(``submission_id`` ``in`` ``submissions_to_delete``)`` ``{`\
`  ``submission`` ``<-`` `[`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)`(``id ``=`` ``submission_id``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
`  ``submission`` ``|>`` `[`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)`(``)`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Successfully deleted submission %s"``, ``submission_id``)``)`\
`}`\
\
`if`` ``(`[`length`](https://rdrr.io/r/base/length.html)`(``submissions_to_delete``)`` ``>`` ``0``)`` ``{`\
`  `[`print`](https://rdrr.io/r/base/print.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Completed deletion of %d requested submissions"``, `[`length`](https://rdrr.io/r/base/length.html)`(``submissions_to_delete``)``)``)`\
`}`

## References

- [`Submission`](https://r-docs.synapse.org/latest/reference/Submission.md)
- [`SubmissionStatus`](https://r-docs.synapse.org/latest/reference/SubmissionStatus.md)
- [`SubmissionBundle`](https://r-docs.synapse.org/latest/reference/SubmissionBundle.md)
- [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)
