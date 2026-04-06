# Constructor for objects of type Folder

Represents a folder in Synapse.

Folders must have a name and a parent and can optionally have
annotations.

## Usage

``` r
Folder(name=NULL, parent=NULL, annotations=NULL)
```

## Arguments

- name:

  The name of the folder  

- parent:

  The parent project or folder  

- annotations:

  A map of user defined annotations  

## Value

An object of type Folder

## Examples

``` r
if (FALSE) { # \dontrun{
folder <- Folder('my data', parent=project, annotations=c(foo='bar', bat=101))
folder <- synStore(folder)
folder$annotations$foo
} # }
```
