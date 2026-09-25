\name{synFromParent}
\alias{Activity_synFromParent}
\docType{methods}
\title{
Activity :  from_parent
}
\description{
Get the Activity from Synapse based on the parent entity.
}
\usage{
synFromParent(cls, parent, parent_version_number=NULL, synapse_client=NULL)
}
\arguments{
\item{cls}{(Activity) The Activity class (or an existing Activity instance) to dispatch this call to.}
\item{parent}{(Union[Table, File, EntityView, Dataset, str]) The parent entity this activity is associated with. The parent may also have a version_number. Gets the most recent version if version is omitted.}
\item{parent_version_number}{(Optional[int]) The version number of the parent entity. When parent is a string with version (e.g., "syn123.4"), the version in the string takes precedence. When parent is an object, this parameter takes precedence over parent$version_number. Gets the most recent version if omitted.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The Activity object, or NULL if it does not exist.
}
\section{Errors}{
An error is raised if the parent does not have an ID.
}
\keyword{Activity}
