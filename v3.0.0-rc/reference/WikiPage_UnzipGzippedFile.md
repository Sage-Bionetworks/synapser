# WikiPage : unzip_gzipped_file

Unzip the gzipped file and return the file path to the unzipped file. If
the file is a markdown file, the content will be printed.

## Usage

``` r
synUnzipGzippedFile(file_path)
```

## Arguments

- file_path:

  (str) The path to the gzipped file.

## Value

The file path to the unzipped file.

## Examples

``` r
if (FALSE) { # \dontrun{
## Unzip a gzipped file
    file_path = "path/to/file.md.gz"
    unzipped_file_path = synUnzipGzippedFile(file_path)
} # }
```
