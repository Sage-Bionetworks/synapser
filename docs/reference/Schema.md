# Constructor for objects of type Schema

A Schema is an Entity that defines a set of columns in a table.

## Usage

``` r
Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, description=NULL)
```

## Arguments

- name:

  the name for the Table Schema object  

- columns:

  a list of Column objects or their IDs  

- parent:

  the project in Synapse to which this table belongs  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

- description:

  optional named parameter: User readable description of the schema  

## Value

An object of type Schema

## Examples

``` r
if (FALSE) { # \dontrun{
cols <- c(Column(name='Isotope', columnType='STRING'),
  Column(name='Atomic Mass', columnType='INTEGER'),
  Column(name='Halflife', columnType='DOUBLE'),
  Column(name='Discovered', columnType='DATE'))

schema <- synStore(Schema(name='MyTable', columns=cols, parent=project))
} # }
```
