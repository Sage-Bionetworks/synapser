\name{Activity-class}
\alias{Activity-class}
\docType{class}
\title{
Activity
}
\format{An R6 class object.}
\description{
Represents the provenance of a Synapse Entity.
}
\section{Methods}{
\itemize{
\item \code{Activity(name=NULL, description=NULL, used=NULL, executed=NULL, data=list())}: Constructor for \code{\link{Activity}}
\item \code{executed(target=NULL, targetVersion=NULL, url=NULL, name=NULL)}: Add a code resource that was executed during the activity.
\item \code{used(target=NULL, targetVersion=NULL, wasExecuted=NULL, url=NULL, name=NULL)}: Add a resource used by the activity.

}
}
\details{
The \code{\link{used}} method tries to be as permissive as possible. It accepts a string which might
be a synapse ID or a URL, a synapse entity or a list containing any combination of these.  Also
allowed are (1) a named list with fields 'target' and 'targetVersion' or 'url' and 'name'.  
See the examples below.
}
\examples{
%
% Verified that the following works on 2018Jan23.
%
\dontrun{
# Entity examples:
#
activity$used('syn12345')
activity$used(entity)
activity$used(target=entity, targetVersion=2)
activity$used(codeEntity, wasExecuted=TRUE)

# URL examples:
# 
activity$used('http://mydomain.com/my/awesome/data.RData')
activity$used(url='http://mydomain.com/my/awesome/data.RData', name='Awesome Data')
activity$used(url='https://github.com/joe_hacker/code_repo', name='Gnarly hacks', wasExecuted=TRUE)
activity$used(list(url='https://github.com/joe_hacker/code_repo', name='Gnarly hacks'), wasExecuted=TRUE)
                  
# In case of conflicting settings for wasExecuted both inside an object and with a
# parameter, the parameter wins. For example, this UsedURL will have wasExecuted set
# to FALSE:
#
activity$used(list(url='http://google.com', name='Goog', wasExecuted=TRUE), wasExecuted=FALSE)
}
}