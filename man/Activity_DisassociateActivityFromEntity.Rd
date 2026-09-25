\name{synDisassociateActivityFromEntity}
\alias{Activity_synDisassociateActivityFromEntity}
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
synDisassociateActivityFromEntity(cls, parent, synapse_client=NULL)
}
\arguments{
\item{cls}{(Activity) The Activity class (or an existing Activity instance) to dispatch this call to.}
\item{parent}{(Union[Table, File, str]) The parent entity this activity is associated with.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\section{Errors}{
An error is raised if the parent does not have an ID.
}
\keyword{Activity}
