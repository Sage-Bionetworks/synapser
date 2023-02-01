\name{synSendMessage}
\alias{synSendMessage}
\docType{methods}
\title{
synSendMessage
}
\description{
send a message via Synapse.
}
\usage{
synSendMessage(userIds, messageSubject, messageBody, contentType = "text/plain")
}
\arguments{
\item{userIds}{         A list of user IDs to which the message is to be sent}
\item{messageSubject}{  The subject for the message}
\item{messageBody}{     The body of the message}
\item{contentType}{     optional contentType of message body (default="text/plain")\cr
                        Should be one of "text/plain" or "text/html"}
}
\value{
 The metadata of the created message
}
\examples{
\dontrun{
synSendMessage(userIds = list("3321601"), messageSubject = "Test message", messageBody = "Hello")
}
}


