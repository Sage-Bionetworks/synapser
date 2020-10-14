%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{synStore}
\docType{methods}
\title{
synStore
}
\description{
Creates a new Entity or updates an existing Entity, uploading any files in the process.
}
\usage{
synStore(obj, createOrUpdate=TRUE, forceVersion=TRUE, versionLabel=NULL, isRestricted=FALSE, activity=NULL, used=NULL, executed=NULL, activityName=NULL, activityDescription=NULL)
}
\arguments{
\item{obj}{                 A Synapse Entity, Evaluation, or Wiki\cr
}
\item{createOrUpdate}{      Indicates whether the method should automatically perform an update if the 'obj'\cr
                            conflicts with an existing Synapse object.  Defaults to True.\cr
}
\item{forceVersion}{        Indicates whether the method should increment the version of the object even if\cr
                            nothing has changed.  Defaults to True.\cr
}
\item{versionLabel}{        Arbitrary string used to label the version.\cr
}
\item{isRestricted}{        If set to true, an email will be sent to the Synapse access control team to start\cr
                            the process of adding terms-of-use or review board approval for this entity.\cr
                            You will be contacted with regards to the specific data being restricted and the\cr
                            requirements of access.}
\item{activity}{            Activity object specifying the user's provenance.\cr
}
\item{used}{                The Entity, Synapse ID, or URL used to create the object (can also be a list of\cr
                            these)\cr
}
\item{executed}{            The Entity, Synapse ID, or URL representing code executed to create the object\cr
                            (can also be a list of these)\cr
}
\item{activityName}{        Activity name to be used in conjunction with *used* and *executed*.\cr
}
\item{activityDescription}{ Activity description to be used in conjunction with *used* and *executed*.\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A Synapse Entity, Evaluation, or Wiki
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
%\dontrun{
%    from synapseclient import Project
%}
}



