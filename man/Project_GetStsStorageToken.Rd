\name{synGetStsStorageToken}
\alias{Project_synGetStsStorageToken}
\docType{methods}
\title{
Project :  get_sts_storage_token
}
\description{
Get STS (AWS Security Token Service) credentials for direct access to
the storage location backing this entity. These credentials can be used
with AWS tools such as the AWS CLI.
}
\usage{
synGetStsStorageToken(instance, permission, output_format="json", min_remaining_life=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{permission}{(character) The permission level for the token. Must be 'read_only' or 'read_write'.}
\item{output_format}{(character) The output format for the credentials. Options:\cr
\cr
- 'json' (default): the credentials exactly as returned by Synapse, as a named list.\cr
- 'boto': a named list with only the \code{aws_access_key_id}, \code{aws_secret_access_key}, and \code{aws_session_token} entries.\cr
- 'bash', 'cmd', or 'powershell': a character string of commands that export the credentials as environment variables in that shell.\cr
- 'shell': the same as one of 'bash', 'cmd', or 'powershell', chosen automatically for the current system.}
\item{min_remaining_life}{(Optional[integer]) The minimum remaining life (in seconds) for a cached token before a new one is fetched.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The STS credentials in the requested format.
}
\section{Errors}{
Raises an error if the entity does not have an id set.
}
\note{
The entity must use a storage location that has STS enabled.
}
\examples{
\dontrun{
## Using credentials with AWS tools
    # Get STS credentials for an STS-enabled project and make them available to
    # AWS tools (such as the AWS CLI) through the standard environment variables.
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    credentials = project |> synGetStsStorageToken(
        permission = "read_write",
        output_format = "boto"
    )
    Sys.setenv(
        AWS_ACCESS_KEY_ID = credentials$aws_access_key_id,
        AWS_SECRET_ACCESS_KEY = credentials$aws_secret_access_key,
        AWS_SESSION_TOKEN = credentials$aws_session_token
    )
}
}
\keyword{Project}
