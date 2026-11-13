%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDelete}
\alias{Activity_synDelete}
\docType{methods}
\title{
Activity :  delete
}
\description{
Delete the Activity from Synapse. The Activity must be disassociated from
all entities before it can be deleted. The first step of this delete call
is to disassociate the Activity from the parent entity. If you have other
entities that are associated with this Activity you must disassociate them
by calling this method on them as well. You'll receive an error for all entities
until the last one which will delete the Activity.
}
\usage{
synDelete(cls, parent, synapse_client=NULL)
}
\arguments{
\item{cls}{(Activity) The Activity class (or an existing Activity instance) to dispatch this call to.}
\item{parent}{(Union[ForwardRef('Table'), ForwardRef('File'), str]) The parent entity this activity is associated with.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
NULL
}
\section{Errors}{
ValueError: If the parent does not have an ID.
}
\keyword{Activity}
