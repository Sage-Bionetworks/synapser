\name{synUpdateActivity}
\alias{synUpdateActivity}
\docType{methods}
\title{
synUpdateActivity
}
\description{
Modifies an existing Activity.
}
\usage{
synUpdateActivity(activity)
}
\arguments{
\item{activity}{  The Activity to be updated.}
}
\value{
 An updated Activity object
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
activity<-Activity()
activity$used("syn123")
activity<-synSetProvenance("syn11678572", activity)
activity$used("syn456")
activity<-synUpdateActivity(activity)
}
}



