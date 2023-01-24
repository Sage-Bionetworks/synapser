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
}
\usage{
synGetProvenance(entity, version=NULL)
}
\arguments{
\item{entity}{  An Entity or Synapse ID to lookup\cr
}
\item{version}{ The version of the Entity to retrieve.\cr
                Gets the most recent version if omitted}
}
\value{
 An Activity object or
          raises exception if no provenance record exists
}


