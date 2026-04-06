# synCreateSnapshotVersion

Create a new Table Version, new View version, or new Dataset version.

## Usage

``` r
synCreateSnapshotVersion(table, comment=NULL, label=NULL, activity=NULL, wait=TRUE)
```

## Arguments

- table:

  The schema of the Table/View, or its ID.  

- comment:

  Optional snapshot comment.  

- label:

  Optional snapshot label.  

- activity:

  Optional activity ID applied to snapshot version.  

- wait:

  True if this method should return the snapshot version after waiting
  for any necessary  
  asynchronous table updates to complete. If False this method will
  return  
  as soon as any updates are initiated.

## Value

the snapshot version number if wait=True, None if wait=False

## Examples

``` r
if (FALSE) { # \dontrun{
synCreateSnapshotVersion(table='syn123', comment='snapshot comment', wait=TRUE)
} # }
```
