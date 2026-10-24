%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{StorageLocation}
\alias{StorageLocation}
\docType{class}
\title{
StorageLocation
}
\format{An S3-style class object.}
\description{
A storage location setting describes where files are uploaded to and
downloaded from via Synapse. Storage location settings may be created for
external locations, such as user-owned Amazon S3 buckets, Google Cloud
Storage buckets, SFTP servers, or proxy storage.
}
\usage{
StorageLocation(storage_location_id=NULL, storage_type=NULL, concrete_type=NULL, banner=NULL, description=NULL, bucket=NULL, base_key=NULL, sts_enabled=FALSE, endpoint_url="https://s3.amazonaws.com", url=NULL, supports_subfolders=FALSE, proxy_url=NULL, secret_key=NULL, benefactor_id=NULL, upload_type=NULL, etag=NULL, created_on=NULL, created_by=NULL)
}
\arguments{
\item{storage_location_id}{(Optional[int]) (Read Only) The unique ID for this storage location, assigned by the server on creation.}
\item{storage_type}{(Optional[StorageLocationType]) The type of storage location. Required when creating a new storage location via \code{store()}. Determines the \code{concreteType} sent to the Synapse REST API.}
\item{concrete_type}{}
\item{banner}{(Optional[str]) The banner text to display to a user every time a file is uploaded. This field is optional.}
\item{description}{(Optional[str]) A description of the storage location. This description is shown when a user has to choose which upload destination to use.}
\item{bucket}{(Optional[str]) The name of the S3 or Google Cloud Storage bucket. Applicable to \code{SYNAPSE_S3}, \code{EXTERNAL_S3}, \code{EXTERNAL_GOOGLE_CLOUD}, and \code{EXTERNAL_OBJECT_STORE} types.}
\item{base_key}{(Optional[str]) The optional base key (prefix/folder) within the bucket. Applicable to \code{SYNAPSE_S3}, \code{EXTERNAL_S3}, and \code{EXTERNAL_GOOGLE_CLOUD} types.}
\item{sts_enabled}{(Optional[bool]) Whether STS (AWS Security Token Service) is enabled on this storage location. Applicable to \code{SYNAPSE_S3} and \code{EXTERNAL_S3} types.}
\item{endpoint_url}{(Optional[str]) The endpoint URL of the S3 service. Applicable to \code{EXTERNAL_S3} (default: https://s3.amazonaws.com) and \code{EXTERNAL_OBJECT_STORE} types.}
\item{url}{(Optional[str]) The base URL for uploading to the external destination. Applicable to \code{EXTERNAL_SFTP} type.}
\item{supports_subfolders}{(Optional[bool]) Whether the destination supports creating subfolders under the base url. Applicable to \code{EXTERNAL_SFTP} type. Default: False.}
\item{proxy_url}{(Optional[str]) The HTTPS URL of the proxy used for upload and download. Applicable to \code{PROXY} type.}
\item{secret_key}{(Optional[str]) The encryption key used to sign all pre-signed URLs used to communicate with the proxy. Applicable to \code{PROXY} type.}
\item{benefactor_id}{(Optional[str]) An Entity ID (such as a Project ID). When set, any user with the 'create' permission on the given benefactorId will be allowed to create ProxyFileHandle using its storage location ID. Applicable to \code{PROXY} type.}
\item{upload_type}{(Optional[UploadType]) (Read Only) The upload type for this storage location. Automatically derived from \code{storage_type}.}
\item{etag}{(Optional[str]) (Read Only) Synapse employs an Optimistic Concurrency Control (OCC) scheme. The E-Tag changes every time the setting is updated.}
\item{created_on}{(Optional[str]) (Read Only) The date this storage location setting was created.}
\item{created_by}{(Optional[int]) (Read Only) The ID of the user that created this storage location setting.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Creating an external S3 storage location
    Create a storage location backed by your own S3 bucket:

        from synapseclient.models import StorageLocation, StorageLocationType

        import synapseclient
        synapseclient.login()

        storage = StorageLocation(
            storage_type=StorageLocationType.EXTERNAL_S3,
            bucket="my-external-synapse-bucket",
            base_key="path/within/bucket",
        ).store()

        print(f"Storage location ID: {storage.storage_location_id}")

## Example 2: Creating a Google Cloud storage location
    Create a storage location backed by your own GCS bucket:

        from synapseclient.models import StorageLocation, StorageLocationType

        import synapseclient
        synapseclient.login()

        storage = StorageLocation(
            storage_type=StorageLocationType.EXTERNAL_GOOGLE_CLOUD,
            bucket="my-gcs-bucket",
            base_key="path/within/bucket",
        ).store()
}
}
\section{Methods}{
\itemize{
\item \code{StorageLocation(storage_location_id=NULL, storage_type=NULL, concrete_type=NULL, banner=NULL, description=NULL, bucket=NULL, base_key=NULL, sts_enabled=FALSE, endpoint_url="https://s3.amazonaws.com", url=NULL, supports_subfolders=FALSE, proxy_url=NULL, secret_key=NULL, benefactor_id=NULL, upload_type=NULL, etag=NULL, created_on=NULL, created_by=NULL)}: Constructor for \code{\link{StorageLocation}}
\item \code{synGet(instance, synapse_client=NULL)}: Retrieve this storage location from Synapse by its ID. Only the creator of\cr
a StorageLocationSetting can retrieve it by its id.
\item \code{synStore(instance, synapse_client=NULL)}: Create this storage location in Synapse. Storage locations are immutable;\cr
this always creates a new one. If a storage location with identical properties\cr
already exists for this user, the existing one is returned (idempotent).
}
}

