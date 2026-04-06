# synCreateStorageLocationSetting

Creates an IMMUTABLE storage location based on the specified type.

## Usage

``` r
synCreateStorageLocationSetting(storage_type, ...)
```

## Arguments

- storage_type:

  the type of the StorageLocationSetting to create  

- ...:

  fields necessary for creation of the specified storage_type, as
  described below

## Details

For each storage_type, the following named values should be specified:  
  
ExternalObjectStorage: (S3-like (e.g. AWS S3 or Openstack) bucket not
accessed by Synapse)  
- endpointUrl: endpoint URL of the S3 service (for example:
'https://s3.amazonaws.com')  
- bucket: the name of the bucket to use  
  
ExternalS3Storage: (Amazon S3 bucket accessed by Synapse)  
- bucket: the name of the bucket to use  
  
ExternalStorage: (SFTP or FTP storage location not accessed by
Synapse)  
- url: the base URL for uploading to the external destination  
- supportsSubfolders(optional): does the destination support creating
subfolders under the base url (default: false)  
  
ProxyStorage: (a proxy server that controls access to a storage)  
- secretKey: The encryption key used to sign all pre-signed URLs used to
communicate with the proxy.  
- proxyUrl: The HTTPS URL of the proxy used for upload and download.  
  
Optional named arguments for ALL types:  
- banner: The optional banner to show every time a file is uploaded  
- description: The description to show the user when the user has to
choose which upload destination to use  

## Value

the created StorageLocationSetting
