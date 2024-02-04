%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetProjectSetting}
\alias{synGetProjectSetting}
\docType{methods}
\title{
synGetProjectSetting
}
\description{
Gets the ProjectSetting for a project.

Arguments:
    project: Project entity or its id as a string
    setting_type: Type of setting. Choose from:

        - `upload`
        - `external_sync`
        - `requester_pays`

Returns:
    The ProjectSetting as a dict or None if no settings of the specified type exist.
}
\usage{
synGetProjectSetting(project, setting_type)
}
\arguments{
\item{project}{}
\item{setting_type}{}
}
\value{

}


