%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetProvenance}
\alias{synGetProvenance}
\docType{methods}
\title{
synGetProvenance
}
\description{
Retrieve provenance information for a Synapse Entity.

Arguments:
    entity:  An Entity or Synapse ID to lookup
    version: The version of the Entity to retrieve. Gets the most recent version if omitted

Returns:
    An Activity object or raises exception if no provenance record exists

Raises:
    SynapseHTTPError: if no provenance record exists
}
\usage{
synGetProvenance(entity, version=NULL)
}
\arguments{
\item{entity}{}
\item{version}{}
}
\value{

}


