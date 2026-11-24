# Evaluations

## Evaluations

An Evaluation is essentially a container that organizes and manages the
submission, assessment, and scoring of data, models, or other research
artifacts. It allows teams to set up challenges where participants
contribute their work, and those contributions can be systematically
reviewed or scored.

This tutorial will walk you through the basics of working with
Evaluations using synapser.

### Tutorial purpose

In this tutorial you will:

1.  Create and update an Evaluation on Synapse
2.  Update the ACL (Access Control List) of an Evaluation on Synapse
3.  Retrieve and delete all Evaluations from a given Project

### Prerequisites

- You have an existing Project on Synapse to work from. If you don’t,
  the [Project](https://r-docs.synapse.org/latest/articles/project.md)
  tutorial shows how to create one.
- You have a Synapse user or team ID to share the evaluation with

## 1. Create and update an Evaluation on Synapse

In this first part, we’ll be showing you how to interact with an
Evaluation object, and how to create and update it on Synapse with
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md).

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`# REQUIRED: Set this to the Synapse user ID or team ID you want to grant permissions to`\
`# Do NOT leave this as NULL - the script will not work properly`\
`PRINCIPAL_ID`` ``<-`` ``NULL`` ``# Replace with actual user/team ID`\
\
`# Retrieve the Project where your Evaluation will be stored`\
`project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(``name ``=`` ``"My uniquely named project about Alzheimer's Disease"``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
`project_id`` ``<-`` ``project``$``id`\
\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Working within Project:"``, ``project_id``, ``"\n"``)`\
\
`# Create a new Evaluation object`\
`evaluation`` ``<-`` `[`Evaluation`](https://r-docs.synapse.org/latest/reference/Evaluation.md)`(`\
`  name ``=`` ``"My Challenge Evaluation for Study ABC - Round 1"``,`\
`  description ``=`` ``"Evaluation for my data challenge"``,`\
`  content_source ``=`` ``project_id``,`\
`  submission_instructions_message ``=`` ``"Submit CSV files only"``,`\
`  submission_receipt_message ``=`` ``"Thank you for your submission!"`\
`)`\
\
`# Create the Evaluation on Synapse`\
`evaluation`` ``<-`` ``evaluation`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Evaluation has been created with the following name and description:\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``evaluation``$``name``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``evaluation``$``description``, ``"\n"``)`\
\
`# Update the Evaluation object's name and description`\
`evaluation``$``name`` ``<-`` ``"My Challenge Evaluation for Study XYZ - Round 1"`\
`evaluation``$``description`` ``<-`` ``"Updated description for my evaluation"`\
\
`# Update the Evaluation on Synapse`\
`evaluation`` ``<-`` ``evaluation`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Evaluation has been updated with the following name and description:\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``evaluation``$``name``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``evaluation``$``description``, ``"\n"``)`

## 2. Update the ACL of an Evaluation on Synapse

Like Synapse entities, Evaluations have ACLs that can be used to control
who has access to your evaluations and what level of access they have.
Updating the ACL of an Evaluation object is slightly different from
updating other Evaluation components, because the ACL is not an
attribute of the Evaluation object. Let’s see an example of how this
looks:

\
`# Update the Evaluation's ACL on Synapse by adding a new user`\
`if`` ``(`[`is.null`](https://rdrr.io/r/base/NULL.html)`(``PRINCIPAL_ID``)``)`` ``{`\
`  `[`stop`](https://rdrr.io/r/base/stop.html)`(``"PRINCIPAL_ID must be set to the Synapse user ID or team ID you want to grant permissions to."``)`\
`}`\
\
`evaluation`` ``|>`` ``synUpdateAcl``(``principal_id ``=`` ``PRINCIPAL_ID``, access_type ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``"READ"``, ``"SUBMIT"``)``)`\
\
`# Get the Evaluation's ACL to confirm the update`\
`acl`` ``<-`` ``evaluation`` ``|>`` ``synGetAcl``(``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"The following ACL has been retrieved from Synapse:\n"``)`\
`acl`

You can also remove principals from an ACL by simply giving
`synUpdateAcl()` an empty list for the `access_type` argument, like so:

\
`# Now let's remove the user we just added from the Evaluation's ACL`\
`evaluation`` ``|>`` ``synUpdateAcl``(``principal_id ``=`` ``PRINCIPAL_ID``, access_type ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``)``)`

## 3. Retrieve and delete all Evaluations from a given Project

Now we will show how you can retrieve lists of Evaluation objects,
rather than retrieving them one at a time. This is a powerful tool if
you want to perform the same action on all the evaluations in a given
project, for example, like what we’re about to do here:

\
`# Finally let's retrieve all Evaluations stored within this project, including the one we just created`\
`evaluations_list`` ``<-`` ``synGetEvaluationsByProject``(``project_id ``=`` ``project_id``)`\
\
`# Let's delete the evaluation we created for this tutorial, and any other evaluations in this project (uncomment below to enable deletion)`\
`for`` ``(``evaluation_to_delete`` ``in`` ``evaluations_list``)`` ``{`\
`  `[`cat`](https://rdrr.io/r/base/cat.html)`(``"Deleting evaluation:"``, ``evaluation_to_delete``$``name``, ``"\n"``)`\
`  ``evaluation_to_delete`` ``|>`` `[`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)`(``)`\
`}`

## References

- [`Evaluation`](https://r-docs.synapse.org/latest/reference/Evaluation.md)
- [`Project`](https://r-docs.synapse.org/latest/reference/Project.md)
- [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)
- [`synGetEvaluationsByProject`](https://r-docs.synapse.org/latest/reference/Evaluation_GetEvaluationsByProject.md)
- [`synGetAllEvaluations`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAllEvaluations.md)
