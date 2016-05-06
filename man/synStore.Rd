\name{synStore}
\alias{synStore}
\title{
Store an object in Synapse
}
\description{
Store an object in Synapse
}
\usage{
synStore(entity, used=NULL, executed=NULL, activityName=NULL, activityDescription=NULL, createOrUpdate=T, forceVersion=T, isRestricted=F, contentType=NULL)
synStore(entity, activity=NULL, createOrUpdate=T, forceVersion=T, isRestricted=F, contentType=NULL)
synStore(table, retrieveData=F, verbose=T, filePath=NULL)
}
\arguments{
 \item{entity}{
The object to store.  May be an entity (\code{\link{File}}, \code{\link{Folder}}, 
\code{\link{Project}}), (\code{\link{Activity}}, \code{\link{Evaluation}}, 
\code{\link{SubmissionStatus}}, \code{\link{WikiPage}}, \code{\link{TableColumn}}, 
\code{\link{Table}}, \code{\link{TableSchema}})
}
 \item{used}{
For entities, this is the list of other entities (URLs, objects and/or IDs) 'used' as inputs when generating the entity.  For non-entities, this parameter is ignored

e.g. used=list(list(entity="syn1234"), list(url="http://myawesomesite.com"))
}
 \item{executed}{
For entities, this is the list of other entities (URLs, objects and/or IDs) 'executed' as software when generating the entity.  For non-entities, this parameter is ignored

e.g. executed=list(list(entity="syn1234"), list(url="http://myawesomesite.com"))
}
 \item{activityName}{
For entities, this is the name of the activity generating the given entity.  For non-entities, this parameter is ignored
}
 \item{activityDescription}{
For entities, this is the description of the activity generating the given entity.  For non-entities, this parameter is ignored
}
 \item{activity}{
As an alternative to specifying 'used', 'executed', 'activityName', and/or 'activityDescription' you may pass an Activity object containing these items.
}
 \item{createOrUpdate}{
For entities only:  If TRUE (the default) then if the entity is new (not retrieved from Synapse) but has the same name and parent, the existing Synapse object is updated with the content of the passed object
}
 \item{forceVersion}{
For versionable entities only:  If TRUE new version of the object is created.  Note, if FALSE this does not mean that a new version is not created:  Whenever a new or modified file is attached to a File entity and stored in Synapse, then Synapse creates a new version itself, regardless of the forceVersion parameter
}
 \item{isRestricted}{
For File entities only:  If TRUE then Download access by others is prevented and the Synapse Access and Compliance Team is contacted to help craft the appropriate Terms of Use.  This argument is employed when uploading sensitive human data.
}
\item{contentType}{
The (optional) contentType, stored when the File is uploaded. If omitted, it is the MIME type inferred from the file's suffix.
}
\item{retrieveData}{
For tables:  If TRUE, returns a copy of the uploaded table.  Otherwise returns a RowReferenceSet, which supplies
the row IDs for the uploaded rows.
}
\item{verbose}{
For tables:  If TRUE, shows progress for uploading and retrieving data.
}
\item{filePath}{
For tables:  If retrieveData=T then this is the file path to which the retrieved result will be saves as a .csv file.
If omitted, will be downloaded to the default file cache location.
}
}
\details{
Stores an object crafted in memory, either creating it in Synapse anew, or updating an existing object.
}

\value{
Returns the persisted copy of the object. 
For TableDataFrame and TableFilePath, if retrieveData=TRUE returns a Table of the same type.  
If retrieveData=FALSE, returns a Table having a slot 'rowCount' which is the number of rows stored.
}

\author{
Bruce Hoff
}

\seealso{
\code{\link{File}}
\code{\link{Folder}}
\code{\link{Project}}
\code{\link{Activity}}
\code{\link{Evaluation}}
\code{\link{SubmissionStatus}}
\code{\link{WikiPage}}
\code{\link{TableColumn}}
\code{\link{TableSchema}}
\code{\link{synGet}}
\code{\link{Table}}
}
