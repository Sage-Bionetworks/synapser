%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Link}
\alias{Link}
\docType{class}
\title{
Link
}
\format{An S3-style class object.}
\description{
A Link entity within Synapse that references another entity.

Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Link.html}{Synapse Link}.
}
\usage{
Link(name=NULL, description=NULL, id=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, parent_id=NULL, target_id=NULL, target_version_number=NULL, links_to_class_name=NULL, activity=NULL, annotations=list(), _last_persistent_instance=NULL, concrete_type=NULL)
}
\arguments{
\item{name}{(Optional[str]) The name of this entity. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses}
\item{description}{(Optional[str]) The description of this entity. Must be 1000 characters or less.}
\item{id}{(Optional[str]) The unique immutable ID for this entity. A new ID will be generated for new Entities. Once issued, this ID is guaranteed to never change or be re-issued}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) (Read Only) The date this entity was created.}
\item{modified_on}{(Optional[str]) (Read Only) The date this entity was last modified.}
\item{created_by}{(Optional[str]) (Read Only) The ID of the user that created this entity.}
\item{modified_by}{(Optional[str]) (Read Only) The ID of the user that last modified this entity.}
\item{parent_id}{(Optional[str]) The ID of the Entity that is the parent of this Entity.}
\item{target_id}{(Optional[str]) The ID of the entity to which this link refers}
\item{target_version_number}{(Optional[int]) The version number of the entity to which this link refers}
\item{links_to_class_name}{(Optional[str]) The synapse Entity's class name that this link points to.}
\item{activity}{(Optional[Activity]) The Activity model represents the main record of Provenance in Synapse. It is analogous to the Activity defined in the W3C Specification on Provenance. Activity cannot be removed during a store operation by setting it to None. You must use Activity.delete_async or Activity.disassociate_from_entity_async.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the link. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty dict {} or None and store the entity.}
\item{_last_persistent_instance}{}
\item{concrete_type}{optional named parameter: Indicates which implementation of Entity this object represents. The value is the fully qualified class name, e.g. org.sagebionetworks.repo.model.FileEntity.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Link(name=NULL, description=NULL, id=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, parent_id=NULL, target_id=NULL, target_version_number=NULL, links_to_class_name=NULL, activity=NULL, annotations=list(), _last_persistent_instance=NULL, concrete_type=NULL)}: Constructor for \code{\link{Link}}
}
}

