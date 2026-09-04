%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDisassociateActivityFromEntity}
\alias{synDisassociateActivityFromEntity}
\docType{methods}
\title{
Activity :  disassociate_from_entity
}
\description{
Disassociate the Activity from the parent entity. This is the first step in
deleting the Activity. If you have other entities that are associated with this
Activity you must disassociate them by calling this method on them as well.
}
\usage{
synDisassociateActivityFromEntity(instance, parent, synapse_client=NULL)
}
\arguments{
\item{instance}{(Activity) The Activity instance to operate on.}
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
