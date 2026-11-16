\name{StorageLocationType}
\alias{StorageLocationType}
\docType{class}
\title{
StorageLocationType
}
\format{An S3-style class object.}
\description{
Describes a Synapse storage location type.

Each instance is a distinct object identified by its \code{name}, so SFTP and
HTTPS remain separate even though they share the same backend
\code{concreteType} (\code{ExternalStorageLocationSetting}).
}
\usage{
StorageLocationType(name, concrete_type)
}
\arguments{
\item{name}{(character) Human-readable identifier (e.g. \code{"EXTERNAL_SFTP"}).}
\item{concrete_type}{(character) The \code{concreteType} suffix sent to the Synapse REST API.}
}
\value{
NULL
}
\section{Supported storage location types}{
A \code{StorageLocationType} is identified by both its \code{name} and its
\code{concrete_type}, so construct it with one of the following pairs:

\tabular{ll}{
\strong{name} \tab \strong{concrete_type} \cr
\code{"SYNAPSE_S3"} \tab \code{"S3StorageLocationSetting"} \cr
\code{"EXTERNAL_S3"} \tab \code{"ExternalS3StorageLocationSetting"} \cr
\code{"EXTERNAL_GOOGLE_CLOUD"} \tab \code{"ExternalGoogleCloudStorageLocationSetting"} \cr
\code{"EXTERNAL_SFTP"} \tab \code{"ExternalStorageLocationSetting"} \cr
\code{"EXTERNAL_HTTPS"} \tab \code{"ExternalStorageLocationSetting"} \cr
\code{"EXTERNAL_OBJECT_STORE"} \tab \code{"ExternalObjectStorageLocationSetting"} \cr
\code{"PROXY"} \tab \code{"ProxyStorageLocationSettings"} \cr
}
}
\examples{
\dontrun{
## Use a storage location type when creating a storage location
    library(synapser)
    synLogin()

    external_s3 = StorageLocationType(
        name = "EXTERNAL_S3",
        concrete_type = "ExternalS3StorageLocationSetting"
    )
    storage = StorageLocation(
        storage_type = external_s3,
        bucket = "my-external-synapse-bucket"
    ) |> synStore()
}
}
\section{Methods}{
\itemize{
\item \code{StorageLocationType(name, concrete_type)}: Constructor for \code{\link{StorageLocationType}}
}
}
