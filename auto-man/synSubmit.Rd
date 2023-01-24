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
Submit an Entity for \href{Evaluation.html}{evaluation}.
}
\usage{
synSubmit(evaluation, entity, name=NULL, team=NULL, silent=FALSE, submitterAlias=NULL, teamName=NULL, dockerTag=latest)
}
\arguments{
\item{evaluation}{      Evaluation queue to submit to\cr
}
\item{entity}{          The Entity containing the Submission\cr
}
\item{name}{            A name for this submission.\cr
                        In the absent of this parameter, the entity name will be used.\cr
}
\item{team}{            (optional) A Team object, ID or name of a Team that is registered for the\cr
                        challenge\cr
}
\item{silent}{          Set to True to suppress output.\cr
}
\item{submitterAlias}{  (optional) A nickname, possibly for display in leaderboards in place of the submitter's\cr
                        name\cr
}
\item{teamName}{        (deprecated) A synonym for submitterAlias\cr
}
\item{dockerTag}{       (optional) The Docker tag must be specified if the entity is a DockerRepository.\cr
                        Defaults to "latest".}
}
\value{
 A Submission object
}

 
\examples{
%\dontrun{
%    evaluation = syn.getEvaluation(123)
%    entity = syn.get('syn456')
%    submission = syn.submit(evaluation, entity, name='Our Final Answer', team='Blue Team')
%}
}
