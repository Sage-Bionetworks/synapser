\name{synStore}
\alias{synStore}
\docType{methods}
\title{
synStore
}
\description{
Creates a new Entity or updates an existing Entity,
uploading any files in the process.
}
\usage{
synStore(obj, createOrUpdate=TRUE, forceVersion=TRUE, versionLabel=NULL, isRestricted=FALSE, activity=NULL, used=NULL, executed=NULL, activityName=NULL, activityDescription=NULL, set_annotations=TRUE)
}
\arguments{
\item{obj}{A Synapse Entity, Evaluation, or Wiki.
}
\item{used}{Optional. The Entity, Synapse ID, or URL used to create the object (can also be a list of these.
}
\item{executed}{Optional. The Entity, Synapse ID, or URL representing code executed to create the object
                (can also be a list of these).
}
\item{activity}{Optional. Activity object specifying the user's provenance.
}
\item{activityName}{Optional. Activity name to be used in conjunction with \emph{used} and \emph{executed}.
}
\item{activityDescription}{Optional. Activity description to be used in conjunction with \emph{used} and \emph{executed}.
}
\item{createOrUpdate}{Optional. Indicates whether the method should automatically perform an update if the 'obj'
                    conflicts with an existing Synapse object. Defaults to TRUE.\cr
}
\item{forceVersion}{Optional. Indicates whether the method should increment the version of the object even if\cr
                            nothing has changed. Defaults to TRUE.\cr
}
\item{versionLabel}{Optional. Arbitrary string used to label the version.
}
\item{isRestricted}{Optional.If set to TRUE, an email will be sent to the Synapse access control team to start the
                    process of adding terms-of-use or review board approval for this entity.
                    You will be contacted with regards to the specific data being restricted and the
                    requirements of access. Defaults to FALSE.}
\item{set_annotations}{If TRUE, set the annotations on the entity. If FALSE, do not set the annotations. Defaults to TRUE.}
}
\value{
 A Synapse Entity, Evaluation, or Wiki
}
%
% Verified that the following works on 2024June28.
%
\examples{
\dontrun{
# Create a new project

project <- Project('My uniquely named project')
project <- synStore(project)

# Adding files with provenance:
#
# A synapse entity *syn1906480* contains data
# entity *syn1917825* contains code
#
activity <- Activity('Fancy Processing',
                      description='No seriously, really fancy processing',
                      used=c('syn1906480', 'http://data_r_us.com/fancy/data.txt'),
                      executed='syn1917825')
file <- File('/path/to/data/file.xyz', description='Fancy new data', parent=project)
file <- synStore(file, activity=activity)

# Evaluation
eval <- Evaluation(name =sprintf("My unique evaluation created on \%s", format(Sys.time(), "\%a \%b \%d \%H\%M\%OS4 \%Y")), 
                   description = "testing",
                   contentSource = project$properties$id,
                   submissionReceiptMessage = "Thank you for your submission!",
                   submissionInstructionsMessage = "This evaluation only accepts files.")
eval <- synStore(eval)

# Wiki
content <- "
# My Wiki Page

Here is a description of my **fantastic** project!
"
wiki = Wiki(title='My Wiki Page',
            owner=project,
            markdown=content,
            attachments=list('/path/to/logo.png'))
wiki <- synStore(wiki)
}
}


