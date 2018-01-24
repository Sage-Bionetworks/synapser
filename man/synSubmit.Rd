\name{synSubmit}
\alias{synSubmit}
\docType{methods}
\title{
synSubmit
}
\description{
Submit an Entity for \href{Evaluation.html}{evaluation}.
}
\usage{
synSubmit(evaluation, entity, name=NULL, team=NULL, silent=FALSE, submitterAlias=NULL, teamName=NULL)
}
\arguments{
\item{evaluation}{ Evaluation queue to submit to\cr
}
\item{entity}{     The Entity containing the Submission\cr
}
\item{name}{       A name for this submission\cr
}
\item{team}{       (optional) A Team object or name of a Team that is registered\cr
                   for the challenge\cr
}
\item{silent}{  Suppress output.\cr
}
\item{submitterAlias}{ (optional) A nickname, possibly for display in leaderboards in place of the submitter's name\cr
}
\item{teamName}{ (deprecated) A synonym for submitterAlias}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A Submission object
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
\examples{
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
%\dontrun{
%    evaluation = syn.getEvaluation(12345)
%    entity = syn.get('syn12345')
%    submission = syn.submit(evaluation, entity, name='Our Final Answer', team='Blue Team')
%}
}



