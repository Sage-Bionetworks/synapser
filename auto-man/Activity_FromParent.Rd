%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synFromParent}
\alias{synFromParent}
\docType{methods}
\title{
Activity :  from_parent
}
\description{
Get the Activity from Synapse based on the parent entity.
}
\usage{
synFromParent(instance, parent, parent_version_number=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Activity) The Activity instance to operate on.}
\item{parent}{(Union[ForwardRef('Table'), ForwardRef('File'), ForwardRef('EntityView'), ForwardRef('Dataset'), str]) The parent entity this activity is associated with. The parent may also have a version_number. Gets the most recent version if version is omitted.}
\item{parent_version_number}{(Optional[int]) The version number of the parent entity. When parent is a string with version (e.g., "syn123.4"), the version in the string takes precedence. When parent is an object, this parameter takes precedence over parent.version_number. Gets the most recent version if omitted.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The activity object or None if it does not exist.
}
\section{Errors}{
ValueError: If the parent does not have an ID.
}
\keyword{Activity}
