\name{sendMessage}
\alias{sendMessage}
\title{
sendMessage
}
\description{
Send a message to one or more Synapse users
}
\usage{
sendMessage(idList, messageSubject, messageBody)
}
\arguments{
 \item{idList}{
A list of one or more Synapse User or Team IDs.  Though IDs are numeric, they should be passed as character arguments.
}
 \item{messageSubject}{
The message subject.
}
 \item{messageBody}{
The message body.
}
}
\details{
Email delivery of the message is subject to the recipient's delivery settings in Synapse.
To send a message to the members of a Team, the sender must also be a member of the Team.
}


\examples{
\dontrun{
 sendMessage(list("1234567"), "message subject", "message body")
}
}

