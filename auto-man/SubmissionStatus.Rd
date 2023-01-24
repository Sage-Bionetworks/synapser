%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SubmissionStatus}
\alias{SubmissionStatus}
\docType{methods}
\title{
Constructor for objects of type SubmissionStatus
}
\description{
Builds an Synapse submission status object.
https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatus.html
}
\usage{
SubmissionStatus(id, etag, status=NULL, submissionAnnotations=NULL, canCancel=NULL, cancelRequested=NULL)
}
\arguments{
\item{id}{ Unique immutable Synapse Id of the Submission\cr
}
\item{etag}{}
\item{status}{optional named parameter:  Status can be one of\cr
               https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatusEnum.html.\cr
}
\item{submissionAnnotations}{optional named parameter:  synapseclient.Annotations to store annotations of submission\cr
}
\item{canCancel}{optional named parameter:  Can this submission be cancelled?\cr
}
\item{cancelRequested}{optional named parameter:  Has user requested to cancel this submission?}
}
\value{
An object of type SubmissionStatus
}


