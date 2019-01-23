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
synSendMessage(userIds, messageSubject, messageBody, contentType = "text/plain"")
}
\arguments{
\item{userIds}{         A list of user IDs to which the message is to be sent}
\item{messageSubject}{  The subject for the message}
\item{messageBody}{     The body of the message}
\item{contentType}{     optional contentType of message body (default="text/plain")\cr
                        Should be one of "text/plain" or "text/html"}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 The metadata of the created message
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
synSendMessage(userIds = list("3321601"), messageSubject = "Test message", messageBody = "Hello")
}



