\name{synGet}
\alias{synGet}
\docType{methods}
\title{
synGet
}
\description{
Gets a Synapse entity from the repository service.
}
\usage{
synGet(entity)
}
\arguments{
\item{entity}{ A Synapse ID (e.g. syn123 or syn123.1, with .1 denoting version), a Synapse Entity object,
               a plain dictionary in which 'id' maps to a Synapse ID or a local file that is stored in
               Synapse (found by the file MD5)
}
\item{version}{Optional. The specific version to get.
        Defaults to the most recent version. If not denoted in the entity input.}
\item{downloadFile}{Optional. Whether associated files(s) should be downloaded.
                    Defaults to TRUE.}
\item{downloadLocation}{Optional. Directory where to download the Synapse File Entity.
                        Defaults to the local cache.}
\item{followLink}{Optional. Whether the link returns the target Entity.
                        Defaults to FALSE.}
\item{ifcollision}{Optional. Determines how to handle file collisions.
                        May be "overwrite.local", "keep.local", or "keep.both".
                        Defaults to "keep.both".}
\item{limitSearch}{Optional. A Synanpse ID used to limit the search in Synapse if entity is specified as a local
                        file.  That is, if the file is stored in multiple locations in Synapse only the ones
                        in the specified folder/project will be returned.}
\item{md5}{Optional. The MD5 checksum for the file, if known. Otherwise if the file is a
        local file, it will be calculated automatically.}
}

\value{
A new Synapse Entity object of the appropriate type.
}
%
% Verified that the following works on 2024June28.
%
\examples{
\dontrun{
## download file
file <- synGet('syn1906479')
print(file$properties$name)
print(file$path)

## download a specific version of a file
file <- synGet('syn1906479', version=1)
print(file$versionLabel)

## to access the file's metadata without downloading the file
file <- synGet("syn1906479", downloadFile = FALSE)
md5 <- file$get("md5")
}
}



