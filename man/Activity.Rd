\name{Activity}
\alias{Activity}
\docType{class}
\title{
Activity
}
\format{An S3-style class object.}
\description{
An activity is a Synapse object that helps to keep track of what objects were used
in an analysis step, as well as what objects were generated. Thus, all relationships
between Synapse objects and an activity are governed by dependencies. That is, an
activity needs to know what it \code{used}, and outputs need to know what activity
they were \code{generatedBy}.
}
\usage{
Activity(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, used=list(), executed=list())
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this activity.}
\item{name}{(Optional[str]) A name for this Activity.}
\item{description}{(Optional[str]) A description for this Activity.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this object was created.}
\item{modified_on}{(Optional[str]) The date this object was last modified.}
\item{created_by}{(Optional[str]) The user that created this object.}
\item{modified_by}{(Optional[str]) The user that last modified this object.}
\item{used}{(list[Union[UsedEntity, UsedURL]]) The entities or URLs used by this Activity. Only \code{\link{UsedEntity}} and \code{\link{UsedURL}} objects are accepted. Other values, such as a plain Synapse ID string (for example \code{"syn123"}), are dropped with no error.}
\item{executed}{(list[Union[UsedEntity, UsedURL]]) The entities or URLs executed by this Activity. Only \code{\link{UsedEntity}} and \code{\link{UsedURL}} objects are accepted. Other values, such as a plain Synapse ID string (for example \code{"syn123"}), are dropped with no error.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Activity(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, used=list(), executed=list())}: Constructor for \code{\link{Activity}}
\item \code{\link[=Activity_synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}(cls, parent, synapse_client=NULL)}: Disassociate the Activity from the parent entity. This is the first step in
deleting the Activity. If you have other entities that are associated with this
Activity you must disassociate them by calling this method on them as well.
\item \code{\link[=Activity_synFromParent]{synFromParent}(cls, parent, parent_version_number=NULL, synapse_client=NULL)}: Get the Activity from Synapse based on the parent entity.
}
}

