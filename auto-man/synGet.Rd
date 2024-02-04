%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{synGet}
\docType{methods}
\title{
synGet
}
\description{
Gets a Synapse entity from the repository service.

Arguments:
    entity:           A Synapse ID, a Synapse Entity object, a plain dictionary in which 'id' maps to a
                        Synapse ID or a local file that is stored in Synapse (found by the file MD5)
    version:          The specific version to get.
                        Defaults to the most recent version.
    downloadFile:     Whether associated files(s) should be downloaded.
                        Defaults to True.
    downloadLocation: Directory where to download the Synapse File Entity.
                        Defaults to the local cache.
    followLink:       Whether the link returns the target Entity.
                        Defaults to False.
    ifcollision:      Determines how to handle file collisions.
                        May be "overwrite.local", "keep.local", or "keep.both".
                        Defaults to "keep.both".
    limitSearch:      A Synanpse ID used to limit the search in Synapse if entity is specified as a local
                        file.  That is, if the file is stored in multiple locations in Synapse only the ones
                        in the specified folder/project will be returned.

Returns:
    A new Synapse Entity object of the appropriate type.
}
\usage{
synGet(entity)
}
\arguments{
\item{entity}{}
}
\value{

}


