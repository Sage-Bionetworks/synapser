# Constructor for objects of type MaterializedViewSchema

A MaterializedViewSchema is an Entity that defines a set of columns in a
materialized view along with the SQL statement.

## Usage

``` r
MaterializedViewSchema(name=NULL, columns=NULL, parent=NULL, definingSQL=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)
```

## Arguments

- name:

  the name for the Materialized View Schema object  

- columns:

  a list of Column objects or their IDs  

- parent:

  the project in Synapse to which this Materialized View belongs  

- definingSQL:

  The synapse SQL statement that defines the data in the materialized
  view. The SQL may  
  contain JOIN clauses on multiple tables.  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

- local_state:

  Internal use only

- description:

  optional named parameter: User readable description of the schema  

## Value

An object of type MaterializedViewSchema
