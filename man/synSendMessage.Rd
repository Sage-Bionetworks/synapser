\name{synSendMessage}
\alias{synSendMessage}
\docType{methods}
\title{
synSendMessage
}
\description{
Send a message via Synapse.
}
\usage{
synSendMessage(userIds, messageSubject, messageBody, contentType="text/plain")
}
\arguments{
\item{userIds}{A list of user IDs to which the message is to be sent}
\item{messageSubject}{The subject for the message}
\item{messageBody}{The body of the message}
\item{contentType}{optional contentType of message body (default="text/plain") Should be one of "text/plain" or "text/html"}
}
\value{
The metadata of the created message
}
\examples{
\dontrun{
## Sending a message
    library(synapser)
    synLogin()

    message = synSendMessage(
        userIds = list(273948L),
        messageSubject = "Data is ready",
        messageBody = "The analysis results have been uploaded to syn123."
    )

    # Send an HTML message
    message = synSendMessage(
        userIds = list(273948L),
        messageSubject = "Data is ready",
        messageBody = "<p>The results are in <b>syn123</b>.</p>",
        contentType = "text/html"
    )
}
}
