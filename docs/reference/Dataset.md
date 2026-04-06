# Constructor for objects of type Dataset

A Dataset is an Entity that defines a flat list of entities as a
tableview (a.k.a. a "dataset").

## Usage

``` r
Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE, description=NULL, folder=NULL)
```

## Arguments

- name:

  The name for the Dataset object  

- columns:

  A list of Column objects or their IDs  

- parent:

  The Synapse Project to which this Dataset belongs  

- properties:

  A map of Synapse properties  

- addDefaultViewColumns:

- addAnnotationColumns:

- ignoredAnnotationColumnNames:

- annotations:

  A map of user defined annotations  

- local_state:

  Internal use only

- dataset_items:

  A list of items characterized by entityId and versionNumber  

- folders:

- force:

- description:

  optional named parameter: User readable description of the schema  

- folder:

  optional named parameter: A list of Folder IDs  

## Value

An object of type Dataset
