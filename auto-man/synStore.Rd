%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{synStore}
\docType{methods}
\title{
synStore
}
\description{
Creates a new Entity or updates an existing Entity, uploading any files in the process.

Arguments:
    obj: A Synapse Entity, Evaluation, or Wiki
    used: The Entity, Synapse ID, or URL used to create the object (can also be a list of these)
    executed: The Entity, Synapse ID, or URL representing code executed to create the object
                (can also be a list of these)
    activity: Activity object specifying the user's provenance.
    activityName: Activity name to be used in conjunction with *used* and *executed*.
    activityDescription: Activity description to be used in conjunction with *used* and *executed*.
    createOrUpdate: Indicates whether the method should automatically perform an update if the 'obj'
                    conflicts with an existing Synapse object.
    forceVersion: Indicates whether the method should increment the version of the object even if nothing
                    has changed.
    versionLabel: Arbitrary string used to label the version.
    isRestricted: If set to true, an email will be sent to the Synapse access control team to start the
                    process of adding terms-of-use or review board approval for this entity.
                    You will be contacted with regards to the specific data being restricted and the
                    requirements of access.
    set_annotations: If True, set the annotations on the entity. If False, do not set the annotations.

Returns:
    A Synapse Entity, Evaluation, or Wiki
}
\usage{
synStore(obj, createOrUpdate=TRUE, forceVersion=TRUE, versionLabel=NULL, isRestricted=FALSE, activity=NULL, used=NULL, executed=NULL, activityName=NULL, activityDescription=NULL, set_annotations=TRUE)
}
\arguments{
\item{obj}{}
\item{createOrUpdate}{}
\item{forceVersion}{}
\item{versionLabel}{}
\item{isRestricted}{}
\item{activity}{}
\item{used}{}
\item{executed}{}
\item{activityName}{}
\item{activityDescription}{}
\item{set_annotations}{}
}
\value{

}


