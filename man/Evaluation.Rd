\name{Evaluation}
\alias{Evaluation}
\docType{methods}
\title{
Evaluation Constructor
}
\description{
Constructor for Evaluation
}
\usage{Evaluation(name, description, contentSource, status, quota, submissionInstructionsMessage, submissionReceiptMessage)}
\arguments{
 \item{name}{
 name for this Evaluation.
 }
 \item{description}{
 description of this Evaluation
 }
 \item{contentSource}{
 Synapse ID of the entity which owns the Evaluation, usually a Project
 }
 \item{status}{
 One of "PLANNED", "OPEN", "CLOSED", or "COMPLETED".  This field is currently required, but is unused and will be removed in the future.
 }
 \item{quota}{
 An object of type SubmissionQuota describing the maximum submissions by an individual or a team per round,
 as well as the beginning, duration and number of rounds in the Challenge.  Both the maximum and the rounds
 are optional.  See the documentation for SubmissionQuota for further details.
 }
 \item{submissionInstructionsMessage}{
 Instructions to be show to participants on how to craft Synapse File objects for submission to the Evaluation.
 }
 \item{submissionReceiptMessage}{
 Message to display by client upon successful submission to the Evaluation.
 }
}

\section{Slots}{
  \describe{
    \item{\code{updateUri}}{
    Synapse URI which will be used to update the Evaluation
    }
    \item{\code{properties}}{
    Synapse properties for an Evaluation object. Properties of interest include:
      \describe{
        \item{\code{id}}{
        unique Synapse ID as set by the system upon synStore (not set by user)
        }
        \item{\code{name}}{
        user supplied name for the Evaluation
        }
        \item{\code{description}}{
        user supplied description of the Evaluation
        }
        \item{\code{contentSource}}{
        Synapse ID of the entity which owns the Evaluation (usually a Project)
        }
        \item{\code{status}}{
        status of the Evaluation - one of: "PLANNED", "OPEN", "CLOSED", or "COMPLETED"
        }
        \item{\code{submissionInstructionMessage}}{
        Instructions to be show to participants on how to craft Synapse File objects for submission to the Evaluation.
        }
        \item{\code{submissionInstructionMessage}}{
        Message to display by client upon successful submission to the Evaluation.
        }
      }
    }
  }
}

\seealso{
\code{\link{synGetEvaluation}}
\code{\link{synStore}}
\code{\link{submit}}
\code{\link{SubmissionQuota}}
}

