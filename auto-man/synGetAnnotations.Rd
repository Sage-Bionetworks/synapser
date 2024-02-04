%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAnnotations}
\alias{synGetAnnotations}
\docType{methods}
\title{
synGetAnnotations
}
\description{
Retrieve annotations for an Entity from the Synapse Repository as a Python dict.

Note that collapsing annotations from the native Synapse format to a Python dict may involve some loss of
information. See `_getRawAnnotations` to get annotations in the native format.

Arguments:
    entity: An Entity or Synapse ID to lookup
    version: The version of the Entity to retrieve.

Returns:
    A [synapseclient.annotations.Annotations][] object, a dict that also has id and etag attributes
}
\usage{
synGetAnnotations(entity, version=NULL)
}
\arguments{
\item{entity}{}
\item{version}{}
}
\value{

}


