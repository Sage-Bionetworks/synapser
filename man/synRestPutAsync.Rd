\name{synRestPutAsync}
\alias{synRestPutAsync}
\docType{methods}
\title{
synRestPutAsync
}
\description{
Sends an HTTP PUT request to the Synapse server.
}
\usage{
synRestPutAsync(uri, body=NULL, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL)
}
\arguments{
\item{uri}{URI on which get is performed}
\item{body}{The payload to be delivered}
\item{endpoint}{Server endpoint. Defaults to repoEndpoint}
\item{headers}{Dictionary of headers to use}
\item{retry_policy}{A retry policy that matches the arguments of \href{https://github.com/Sage-Bionetworks/synapsePythonClient/blob/0310ba9ad39a599b9d2240028a79792b05f45ee1/synapseclient/core/retry.py#L262}{synapseclient.core.retry.with_retry_time_based_async}.}
\item{requests_session_async_synapse}{The async client to use when making this
        specific call.}
\item{...}{Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method}
}
\value{
JSON encoding of response
}
%
% Verified that the following works on 2024July3.
%
\examples{
\dontrun{
library(jsonlite)
# create payload
request <- list(includeEntity = TRUE)
body <- toJSON(request, auto_unbox = TRUE)

# a helper function to run async function
run_coroutine <- function(coroutine) {
    asyncio <- import("asyncio")
    result <- asyncio$run(coroutine)
    return(result)
    }
# run the coroutine to get the entity bundle
entity_bundle <- run_coroutine(synRestPostAsync(uri="/entity/entity_id/bundle2",body=body))

# update a field on the entity
entity_bundle$entity$description <- "NEW_DESCRIPTION"

# update the entity back to Synapse
request <- list(entity = entity_bundle$entity)
body <- toJSON(request, auto_unbox = TRUE)
updated_entity_bundle = run_coroutine(synRestPutAsync(uri=paste0("/entity/",entity_bundle$entity$id,"/bundle2"), body=body))
}
}
