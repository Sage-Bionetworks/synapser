%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
synSendMessage(userIds, messageSubject, messageBody, contentType=text/plain)
}
\arguments{
\item{userIds}{         A list of user IDs to which the message is to be sent\cr
}
\item{messageSubject}{  The subject for the message\cr
}
\item{messageBody}{     The body of the message\cr
}
\item{contentType}{     optional contentType of message body (default="text/plain")\cr
                        Should be one of "text/plain" or "text/html"}
}
\value{
 The metadata of the created message
}


