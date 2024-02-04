%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{File}
\alias{File}
\docType{methods}
\title{
Constructor for objects of type File
}
\description{
Represents a file in Synapse.

When a File object is stored, the associated local file or its URL will be stored in Synapse.
A File must have a path (or URL) and a parent. By default, the name of the file in Synapse
matches the filename, but by specifying the `name` attribute, the File Entity name can be different.

## Changing File Names

A Synapse File Entity has a name separate from the name of the actual file it represents.
When a file is uploaded to Synapse, its filename is fixed, even though the name of the entity
can be changed at any time. Synapse provides a way to change this filename and the
content-type of the file for future downloads by creating a new version of the file
with a modified copy of itself. This can be done with the
[synapseutils.copy_functions.changeFileMetaData][] function.

    import synapseutils
    e = syn.get(synid)
    print(os.path.basename(e.path))  ## prints, e.g., "my_file.txt"
    e = synapseutils.changeFileMetaData(syn, e, "my_newname_file.txt")

Setting *fileNameOverride* will **not** change the name of a copy of the
file that's already downloaded into your local cache. Either rename the
local copy manually or remove it from the cache and re-download.:

    syn.cache.remove(e.dataFileHandleId)
    e = syn.get(e)
    print(os.path.basename(e.path))  ## prints "my_newname_file.txt"

Parameters:
    path: Location to be represented by this File
    name: Name of the file in Synapse, not to be confused with the name within the path
    parent: Project or Folder where this File is stored
    synapseStore: Whether the File should be uploaded or if only the path should
                    be stored when [synapseclient.Synapse.store][] is called on the File object.
    contentType: Manually specify Content-type header, for example "application/png" or
                    "application/json; charset=UTF-8"
    dataFileHandleId: Defining an existing dataFileHandleId will use the existing dataFileHandleId
                        The creator of the file must also be the owner of the dataFileHandleId
                        to have permission to store the file.
    properties: A map of Synapse properties
    annotations: A map of user defined annotations
    local_state: Internal use only
}
\usage{
File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{path}{}
\item{parent}{}
\item{synapseStore}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type File
}


