# Constructor for objects of type Link

Represents a link in Synapse.

Links must have a target ID and a parent. When you do synGet on a Link
object, the Link object is returned. If the target is desired, specify
followLink=TRUE in synGet().

## Usage

``` r
Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL)
```

## Arguments

- targetId:

  The ID of the entity to be linked  

- targetVersion:

  The version of the entity to be linked  

- parent:

  The parent project or folder  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

## Value

An object of type Link

## Examples

``` r
if (FALSE) { # \dontrun{
# create a link to 'syn1234567' under some other folder
link <- Link('syn1234567', parent=folder)
link <- synStore(link)
} # }
```
