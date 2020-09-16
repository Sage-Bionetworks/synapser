%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet_sts_storage_token}
\alias{synGet_sts_storage_token}
\docType{methods}
\title{
synGet_sts_storage_token
}
\description{
Get STS credentials for the given entity_id and permission, outputting it in the given format
}
\usage{
synGet_sts_storage_token(entity, permission, output_format=json, min_remaining_life=NULL)
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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{

}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{

}



