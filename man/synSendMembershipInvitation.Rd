\name{synSendMembershipInvitation}
\alias{synSendMembershipInvitation}
\docType{methods}
\title{
synSendMembershipInvitation
}
\description{
Create a membership invitation and send an email notification
to the invitee.
}
\usage{
synSendMembershipInvitation(teamId, inviteeId=NULL, inviteeEmail=NULL, message=NULL)
}
\arguments{
\item{teamId}{ Synapse teamId\cr
}
\item{inviteeId}{ Synapse username or profile id of user\cr
}
\item{inviteeEmail}{ Email of user\cr
}
\item{message}{ Additional message for the user getting invited to the\cr
                team. Default to None.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 MembershipInvitation
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
\examples{
\dontrun{
synSendMembershipInviation(teamId, inviteeEmail='john.doe@example.com', message='You should join this Synapse team!')

}
}



