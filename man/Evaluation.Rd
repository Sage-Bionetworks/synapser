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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Evaluation
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
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



