%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{Activity_synStore}
\docType{methods}
\title{
Activity :  store
}
\description{
Store the Activity in Synapse.
}
\usage{
synStore(instance, parent=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Activity) The Activity instance to operate on.}
\item{parent}{(Optional[Union[ForwardRef('Table'), ForwardRef('File'), ForwardRef('EntityView'), ForwardRef('Dataset'), str]]) The parent entity to associate this activity with. Can be an entity object or a string ID (e.g., "syn123").}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The activity object.
}
\section{Errors}{
ValueError: Raised if both of the following are true:

        - If the parent does not have an ID.
        - If the Activity does not have an ID and ETag.
}
\keyword{Activity}
