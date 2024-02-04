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

Arguments:
    userIds: A list of user IDs to which the message is to be sent
    messageSubject: The subject for the message
    messageBody: The body of the message
    contentType: optional contentType of message body (default="text/plain")
                    Should be one of "text/plain" or "text/html"

Returns:
    The metadata of the created message
}
\usage{
synSendMessage(userIds, messageSubject, messageBody, contentType=text/plain)
}
\arguments{
\item{userIds}{}
\item{messageSubject}{}
\item{messageBody}{}
\item{contentType}{}
}
\value{

}


