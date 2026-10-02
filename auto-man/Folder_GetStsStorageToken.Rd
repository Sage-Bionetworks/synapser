%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetStsStorageToken}
\alias{Folder_synGetStsStorageToken}
\docType{methods}
\title{
Folder :  get_sts_storage_token
}
\description{
Get STS (AWS Security Token Service) credentials for direct access to
the storage location backing this entity. These credentials can be used
with AWS tools like awscli and boto3.
}
\usage{
synGetStsStorageToken(instance, permission, output_format="json", min_remaining_life=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{permission}{(str) The permission level for the token. Must be 'read_only' or 'read_write'.}
\item{output_format}{(str) The output format for the credentials. Options: 'json' (default), 'boto', 'shell', 'bash', 'cmd', 'powershell'.}
\item{min_remaining_life}{(Optional[int]) The minimum remaining life (in seconds) for a cached token before a new one is fetched.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The STS credentials in the requested format.
}
\section{Errors}{
ValueError: If the entity does not have an id set.
}
\note{
The entity must use a storage location that has STS enabled.
}
\examples{
\dontrun{
## Using credentials with boto3
    Get STS credentials for an STS-enabled folder and use with boto3:

        import asyncio
        import boto3
        from synapseclient import Synapse
        from synapseclient.models import Folder

        syn = Synapse()
        syn.login()

        async def main():
            folder = await Folder(id="syn123").get_async()
            credentials = await folder.get_sts_storage_token_async(
                permission="read_write",
                output_format="boto",
            )
            s3_client = boto3.client('s3', **credentials)

        asyncio.run(main())
}
}
\keyword{Folder}
