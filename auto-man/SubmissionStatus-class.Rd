%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SubmissionStatus-class}
\alias{SubmissionStatus-class}
\docType{class}
\title{
SubmissionStatus
}
\format{An R6 class object.}
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
\section{Methods}{
\itemize{
\item \code{SubmissionStatus(id, etag)}: Constructor for \code{\link{SubmissionStatus}}
\item \code{json(ensure_ascii=TRUE)}: Overloaded json function, turning submissionAnnotations into\cr
synapse style annotations.\cr
\cr
Arguments:\cr
    ensure_ascii: (default = True) If false, then the return value can contain non-ASCII\cr
    characters. Otherwise, all such characters are escaped in JSON strings.\cr
Returns:\cr
    A Synapse-style JSON dictionary of annotations.
}
}

