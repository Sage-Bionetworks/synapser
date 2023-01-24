\name{synGetProjectSetting}
\alias{synGetProjectSetting}
\docType{methods}
\title{
synGetProjectSetting
}
\description{
Gets the ProjectSetting for a project.
}
\usage{
synGetProjectSetting(project, setting_type)
}
\arguments{
\item{project}{ Project entity or its id as a string\cr
}
\item{setting_type}{ type of setting. Choose from: {'upload', 'external_sync', 'requester_pays'}}
}
\value{
 The ProjectSetting as a named list or NULL if no settings of the specified type exist.
}




