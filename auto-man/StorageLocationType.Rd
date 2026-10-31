%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{StorageLocationType}
\alias{StorageLocationType}
\docType{class}
\title{
StorageLocationType
}
\format{An S3-style class object.}
\description{
Describes a Synapse storage location type.

Each instance is a distinct object identified by its `\code{name}\code{, so SFTP and
HTTPS remain separate even though they share the same backend
}\code{concreteType}\code{ (}\code{ExternalStorageLocationSetting}`).
}
\usage{
StorageLocationType(name, concrete_type)
}
\arguments{
\item{name}{(str) Human-readable identifier (e.g. `\code{"EXTERNAL_SFTP"}`).}
\item{concrete_type}{(str) The `\code{concreteType}` suffix sent to the Synapse REST API.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{StorageLocationType(name, concrete_type)}: Constructor for \code{\link{StorageLocationType}}
}
}

