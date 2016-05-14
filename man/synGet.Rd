\name{synGet}
\alias{synGet}
\docType{methods}
\title{
synGet
}
\description{}
\usage{
	synGet(...)
}
\arguments{
\item{...}{Extra parameters, passed by argument name.}
}
\details{
Gets a Synapse entity from the repository service.

:param entity:           A Synapse ID, a Synapse Entity object,
                         a plain dictionary in which 'id' maps to a Synapse ID or
                         a local file that is stored in Synapse (found by hash of file)
:param version:          The specific version to get.
                         Defaults to the most recent version.
:param downloadFile:     Whether associated files(s) should be downloaded.
                         Defaults to True
:param downloadLocation: Directory where to download the Synapse File Entity.
                         Defaults to the local cache.
:param followLink:       Whether the link returns the target Entity.
                         Defaults to True
:param ifcollision:      Determines how to handle file collisions.
                         May be "overwrite.local", "keep.local", or "keep.both".
                         Defaults to "keep.both".
:param limitSearch:      a Synanpse ID used to limit the search in Synapse if entity is
                         specified as a local file.  That is, if the file is stored in multiple
                         locations in Synapse only the ones in the specified folder/project will be
                         returned.

:returns: A new Synapse Entity object of the appropriate type

Example::

    ## download file into cache
    entity = syn.get('syn1906479')
    print(entity.name)
    print(entity.path)

    ## download file into current working directory
    entity = syn.get('syn1906479', downloadLocation='.')
    print(entity.name)
    print(entity.path)

   ## Determine the provenance of a localy stored file as indicated in Synapse
   entity = syn.get('/path/to/file.txt', limitSearch='syn12312')
   print(syn.getProvenance(entity))
}

