%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synTableUpdateResponseFromDict}
\alias{synTableUpdateResponseFromDict}
\docType{methods}
\title{
synTableUpdateResponseFromDict
}
\description{
Convert a single response of a TableUpdateTransactionResponse into the dataclass
that models it. Dispatch is on the concrete type that Synapse reported. A response
that reports no concrete type, or one that this release does not model, is held as
an UnknownTableUpdateResponse rather than guessed at from the keys it carries.
}
\usage{
synTableUpdateResponseFromDict(data)
}
\arguments{
\item{data}{(dict[str, Any]) One element of the results array of a <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/TableUpdateTransactionResponse.html>}
}
\value{
An instance of the matching TableUpdateResponse subclass, or an
    UnknownTableUpdateResponse holding the raw response when the response
    cannot be identified.
}

