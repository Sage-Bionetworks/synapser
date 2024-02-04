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
<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatus.html>

Arguments:
    id: Unique immutable Synapse Id of the Submission
    status: Status can be one of
               <https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatusEnum.html>.
    submissionAnnotations: synapseclient.Annotations to store annotations of submission
    canCancel: Can this submission be cancelled?
    cancelRequested: Has user requested to cancel this submission?
}
\usage{
SubmissionStatus(id, etag)
}
\arguments{
\item{id}{}
\item{etag}{}
}
\value{
An object of type SubmissionStatus
}


