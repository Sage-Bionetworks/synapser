# synGet

Gets a Synapse entity from the repository service.

## Usage

``` r
synGet(entity)
```

## Arguments

- entity:

  A Synapse ID (e.g. syn123 or syn123.1, with .1 denoting version), a
  Synapse Entity object, a plain dictionary in which 'id' maps to a
  Synapse ID or a local file that is stored in Synapse (found by the
  file MD5)

- version:

  Optional. The specific version to get. Defaults to the most recent
  version. If not denoted in the entity input.

- downloadFile:

  Optional. Whether associated files(s) should be downloaded. Defaults
  to TRUE.

- downloadLocation:

  Optional. Directory where to download the Synapse File Entity.
  Defaults to the local cache.

- followLink:

  Optional. Whether the link returns the target Entity. Defaults to
  FALSE.

- ifcollision:

  Optional. Determines how to handle file collisions. May be
  "overwrite.local", "keep.local", or "keep.both". Defaults to
  "keep.both".

- limitSearch:

  Optional. A Synanpse ID used to limit the search in Synapse if entity
  is specified as a local file. That is, if the file is stored in
  multiple locations in Synapse only the ones in the specified
  folder/project will be returned.

- md5:

  Optional. The MD5 checksum for the file, if known. Otherwise if the
  file is a local file, it will be calculated automatically.

## Value

A new Synapse Entity object of the appropriate type.

## Examples

``` r
if (FALSE) { # \dontrun{
## download file
file <- synGet('syn1906479')
print(file$properties$name)
print(file$path)

## download a specific version of a file
file <- synGet('syn1906479', version=1)
print(file$versionLabel)

## to access the file's metadata without downloading the file
file <- synGet("syn1906479", downloadFile = FALSE)
md5 <- file$get("md5")
} # }
```
