# Constructor for objects of type SubmissionViewSchema

A SubmissionViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes

## Usage

``` r
SubmissionViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)
```

## Arguments

- name:

  the name of the Entity View Table object  

- columns:

  a list of Column objects or their IDs. These are optional.  

- parent:

  the project in Synapse to which this table belongs  

- scopes:

  a list of Evaluation Queues or their ids  

- addDefaultViewColumns:

  If true, adds all default columns (e.g. name, createdOn, modifiedBy
  etc.)  
  Defaults to True.  
  The default columns will be added after a call to  
  synapseclient.Synapse.store.  

- addAnnotationColumns:

  If true, adds columns for all annotation keys defined across all
  Entities in  
  the SubmissionViewSchema's scope. Defaults to True.  
  The annotation columns will be added after a call to  
  synapseclient.Synapse.store.  

- ignoredAnnotationColumnNames:

  A list of strings representing annotation names.  
  When addAnnotationColumns is True, the names in this list will not
  be  
  automatically added as columns to the SubmissionViewSchema if they
  exist in  
  any of the defined scopes.  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

- local_state:

  Internal use only

## Value

An object of type SubmissionViewSchema
