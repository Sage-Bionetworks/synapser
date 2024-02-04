%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetStsStorageToken}
\alias{synGetStsStorageToken}
\docType{methods}
\title{
synGetStsStorageToken
}
\description{
Get STS credentials for the given entity_id and permission, outputting it in the given format

Arguments:
    entity: The entity or entity id whose credentials are being returned
    permission: One of:

        - `read_only`
        - `read_write`

    output_format: One of:

        - `json`: the dictionary returned from the Synapse STS API including expiration
        - `boto`: a dictionary compatible with a boto session (aws_access_key_id, etc)
        - `shell`: output commands for exporting credentials appropriate for the detected shell
        - `bash`: output commands for exporting credentials into a bash shell
        - `cmd`: output commands for exporting credentials into a windows cmd shell
        - `powershell`: output commands for exporting credentials into a windows powershell

    min_remaining_life: The minimum allowable remaining life on a cached token to return. If a cached token
                        has left than this amount of time left a fresh token will be fetched
}
\usage{
synGetStsStorageToken(entity, permission, output_format=json, min_remaining_life=NULL)
}
\arguments{
\item{entity}{}
\item{permission}{}
\item{output_format}{}
\item{min_remaining_life}{}
}
\value{

}


