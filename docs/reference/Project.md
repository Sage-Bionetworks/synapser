# Constructor for objects of type Project

Represents a project in Synapse.

Projects in Synapse must be uniquely named. Trying to create a project
with a name that's already taken, say 'My project', will result in an
error

## Usage

``` r
Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL, alias=NULL)
```

## Arguments

- name:

  The name of the project

- properties:

  A map of Synapse properties

- annotations:

  A map of user defined annotations

- local_state:

  Internal use only

- alias:

  The project alias for use in friendly project urls

## Value

An object of type Project

## Examples

``` r
if (FALSE) { # \dontrun{
project <- Project('Foobarbat ddd project', properties=list(alias='foobarbat'), annotations=list(foo='bar', bat=101))
project <- synStore(project)
project$properties
project$annotations$foo
} # }
```
