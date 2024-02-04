%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSubmit}
\alias{synSubmit}
\docType{methods}
\title{
synSubmit
}
\description{
Submit an Entity for [evaluation][synapseclient.evaluation.Evaluation].

Arguments:
    evalation: Evaluation queue to submit to
    entity: The Entity containing the Submissions
    name: A name for this submission. In the absent of this parameter, the entity name will be used.
            (Optional) A [synapseclient.team.Team][] object, ID or name of a Team that is registered for the challenge
    team: (optional) A [synapseclient.team.Team][] object, ID or name of a Team that is registered for the challenge
    silent: Set to True to suppress output.
    submitterAlias: (optional) A nickname, possibly for display in leaderboards in place of the submitter's name
    teamName: (deprecated) A synonym for submitterAlias
    dockerTag: (optional) The Docker tag must be specified if the entity is a DockerRepository.

Returns:
    A [synapseclient.evaluation.Submission][] object


In the case of challenges, a team can optionally be provided to give credit to members of the team that
contributed to the submission. The team must be registered for the challenge with which the given evaluation is
associated. The caller must be a member of the submitting team.
}
\usage{
synSubmit(evaluation, entity, name=NULL, team=NULL, silent=FALSE, submitterAlias=NULL, teamName=NULL, dockerTag=latest)
}
\arguments{
\item{evaluation}{}
\item{entity}{}
\item{name}{}
\item{team}{}
\item{silent}{}
\item{submitterAlias}{}
\item{teamName}{}
\item{dockerTag}{}
}
\value{

}


