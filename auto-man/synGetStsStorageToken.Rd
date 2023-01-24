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
}
\usage{
synGetStsStorageToken(entity, permission, output_format=json, min_remaining_life=NULL)
}
\arguments{
\item{entity}{          the entity or entity id whose credentials are being returned\cr
}
\item{permission}{      one of 'read_only' or 'read_write'\cr
}
\item{output_format}{   one of 'json', 'boto', 'shell', 'bash', 'cmd', 'powershell'\cr
                        json: the dictionary returned from the Synapse STS API including expiration\cr
                        boto: a dictionary compatible with a boto session (aws_access_key_id, etc)\cr
                        shell: output commands for exporting credentials appropriate for the detected shell\cr
                        bash: output commands for exporting credentials into a bash shell\cr
                        cmd: output commands for exporting credentials into a windows cmd shell\cr
                        powershell: output commands for exporting credentials into a windows powershell\cr
}
\item{min_remaining_life}{ the minimum allowable remaining life on a cached token to return. if a cached token\cr
    has left than this amount of time left a fresh token will be fetched}
}
\value{

}


