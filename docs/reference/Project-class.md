# Project

Represents a project in Synapse.

Projects in Synapse must be uniquely named. Trying to create a project
with a name that's already taken, say 'My project', will result in an
error

## Format

An R6 class object.

## Attributes

- name: The name of the project  

- alias: The project alias for use in friendly project urls  

- properties: A map of Synapse properties  

- annotations: A map of user defined annotations  

- local_state: Internal use only  

## Methods

- `Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL, alias=NULL)`:
  Constructor for
  [`Project`](https://r-docs.synapse.org/reference/Project.md)

- `local_state(state=NULL)`: Set or get the object's internal state,
  excluding properties, or annotations.  

  ### Arguments

  state: A dictionary containing the object's internal state

  ### Returns

  The object's internal state, excluding properties, or annotations
