\name{synDelete}
\alias{synDelete}
\title{
synDelete
}
\description{
Delete an object from Synapse
}
\usage{
synDelete(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{object}{
One of an Entity, Activity, Evaluation, WikiPage, or Submission.
}
}
\details{
Deletes the given object from Synapse.
}

\seealso{
\code{\link{synStore}}
}
\examples{
\dontrun{
	evaluation<-synGetEvaluation("123456")
	synDelete(evaluation)
}
}

