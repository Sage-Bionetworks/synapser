\name{Evaluation}
\alias{Evaluation}
\docType{methods}
\title{
Constructor for objects of type Evaluation
}
\description{
An Evaluation Submission queue, allowing submissions, retrieval and scoring.
}
\usage{
Evaluation(name=NULL, description=NULL, contentSource=NULL, submissionReceiptMessage=NULL, submissionInstructionsMessage=NULL)
}
\arguments{
\item{name}{optional named parameter:           Name of the evaluation\cr
}
\item{description}{optional named parameter:    A short description of the evaluation\cr
}
\item{contentSource}{optional named parameter:  Synapse Project associated with the evaluation\cr
}
\item{submissionReceiptMessage}{optional named parameter:  Message to display to users upon submission\cr
}
\item{submissionInstructionsMessage}{optional named parameter:  Message to display to users detailing acceptable formatting for submissions.}
}
\value{
An object of type Evaluation
}
\examples{
\dontrun{
eval <- Evaluation(
  name = sprintf("My unique evaluation created on \%s", format(Sys.time(), "\%a \%b \%d \%H\%M\%OS4 \%Y")),
  description = "testing",
  contentSource = project$properties$id,
  submissionReceiptMessage = "Thank you for your submission!",
  submissionInstructionsMessage = "This evaluation only accepts files.")
eval <- synStore(eval)
}
}



