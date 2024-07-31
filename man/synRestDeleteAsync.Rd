\name{synRestDeleteAsync}
\alias{synRestDeleteAsync}
\docType{methods}
\title{
synRestDeleteAsync
}
\description{
Sends an HTTP DELETE request to the Synapse server.
}
\usage{
synRestDeleteAsync(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL)
}
\arguments{
\item{uri}{URI of resource to be deleted}
\item{endpoint}{Server endpoint. Defaults to repoEndpoint}
\item{headers}{Dictionary of headers to use}
\item{retry_policy}{A retry policy that matches the arguments of \href{https://github.com/Sage-Bionetworks/synapsePythonClient/blob/0310ba9ad39a599b9d2240028a79792b05f45ee1/synapseclient/core/retry.py#L262}{synapseclient.core.retry.with_retry_time_based_async}.}
\item{requests_session_async_synapse}{The async client to use when making this
        specific call}
\item{...}{Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method}
}
\value{
Null
}
%
% Verified that the following works on 2024July2.
%
\examples{
\dontrun{
# a helper function to run async function
run_coroutine <- function(coroutine) {
    asyncio <- import("asyncio")
    result <- asyncio$run(coroutine)
    return(result)
    }
# run the coroutine
result <- run_coroutine(synRestDeleteAsync(uri="/entity/<your_entity_id>"))
}
}


