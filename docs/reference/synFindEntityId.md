# synFindEntityId

Find an Entity given its name and parent.

## Usage

``` r
synFindEntityId(name, parent=NULL)
```

## Arguments

- name:

  name of the entity to find  

- parent:

  An Entity object or the Id of an entity as a string. Omit if searching
  for a Project by name

## Value

the Entity ID or NULL if not found

## Examples

``` r
if (FALSE) { # \dontrun{
synFindEntityId("my_test_file.txt", parent = "syn123")
} # }
```
