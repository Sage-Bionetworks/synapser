\name{Project}
\alias{Project}
\docType{methods}
\title{
Constructor for objects of type Project
}
\description{
Represents a project in Synapse.

Projects in Synapse must be uniquely named. Trying to create a project with a name that's already taken, say
'My project', will result in an error
}
\usage{
Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL, alias=NULL)
}
\arguments{
\item{name}{The name of the project}
\item{properties}{A map of Synapse properties}
\item{annotations}{A map of user defined annotations}
\item{local_state}{Internal use only}
\item{alias}{The project alias for use in friendly project urls}
}
\value{
An object of type Project
}
%
% Verified that the following works on 2024June27.
%
\examples{
\dontrun{
project <- Project('Foobarbat ddd project', properties=list(alias='foobarbat'), annotations=list(foo='bar', bat=101))
project <- synStore(project)
project$properties
project$annotations$foo
}
}