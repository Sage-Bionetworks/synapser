\name{synStore}
\alias{synStore}
\docType{methods}
\title{
synStore
}
\description{
Creates a new Entity or updates an existing Entity,
uploading any files in the process.
}
\usage{
synStore(obj, used=NULL, executed=NULL, activity=NULL, activityName=NULL, activityDescription=NULL, createOrUpdate=NULL, forceVersion=NULL, versionLabel=NULL, isRestricted=NULL)
}
\arguments{
\item{obj}{                 A Synapse Entity, Evaluation, or Wiki\cr
}
\item{used}{optional named parameter:                 The Entity, Synapse ID, or URL\cr
                            used to create the object (can also be a list of these)\cr
}
\item{executed}{optional named parameter:             The Entity, Synapse ID, or URL representing code executed\cr
                            to create the object (can also be a list of these)\cr
}
\item{activity}{optional named parameter:             Activity object specifying the user's provenance\cr
}
\item{activityName}{optional named parameter:         Activity name to be used in conjunction with *used* and *executed*.\cr
}
\item{activityDescription}{optional named parameter:  Activity description to be used in conjunction with *used* and *executed*.\cr
}
\item{createOrUpdate}{optional named parameter:       Indicates whether the method should automatically perform an update if the 'obj'\cr
                            conflicts with an existing Synapse object.  Defaults to TRUE.\cr
}
\item{forceVersion}{optional named parameter:         Indicates whether the method should increment the version of the object even if\cr
                            nothing has changed.  Defaults to TRUE.\cr
}
\item{versionLabel}{optional named parameter:         Arbitrary string used to label the version.\cr
}
\item{isRestricted}{optional named parameter:         If set to true, an email will be sent to the Synapse access control team\cr
                            to start the process of adding terms-of-use\cr
                            or review board approval for this entity.\cr
                            You will be contacted with regards to the specific data being restricted\cr
                            and the requirements of access.}
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
\examples{
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\dontrun{
# Create a new project
project <- Project('My uniquely named project')
project <- synStore(project)

# Adding files with provenance:
#
# A synapse entity *syn1906480* contains data
# entity *syn1917825* contains code
activity <- Activity(
    'Fancy Processing',
    description='No seriously, really fancy processing',
    used=c('syn1906480', 'http://data_r_us.com/fancy/data.txt'),
    executed='syn1917825')

test_entity <- File('/path/to/data/file.xyz', description='Fancy new data', parent=project)
test_entity <- synStore(test_entity, activity=activity)
}
}



