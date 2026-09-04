%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSubmissionCount}
\alias{synGetSubmissionCount}
\docType{methods}
\title{
Submission :  get_submission_count
}
\description{
Gets the number of Submissions for a specified Evaluation queue, optionally filtered by submission status.
}
\usage{
synGetSubmissionCount(instance, evaluation_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Submission) The Submission instance to operate on.}
\item{evaluation_id}{(str) The ID of the evaluation queue.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A response JSON containing the submission count.
}
\examples{
\dontrun{
## Getting submission count
    # Get the total number of submissions from a specific evaluation.
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    async def get_submission_count_example():
        response = await Submission.get_submission_count_async(
            evaluation_id="9999999"
        )
        print(f"Found {response} submissions")

    asyncio.run(get_submission_count_example())
}
}
\keyword{Submission}
