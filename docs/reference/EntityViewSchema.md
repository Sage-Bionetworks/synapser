# Constructor for objects of type EntityViewSchema

A EntityViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes

## Usage

``` r
EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, includeEntityTypes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL)
```

## Arguments

- name:

  the name of the Entity View Table object  

- columns:

  a list of Column objects or their IDs. These are optional.  

- parent:

  the project in Synapse to which this table belongs  

- scopes:

  a list of Projects/Folders or their ids  

- type:

  This field is deprecated. Please use \`includeEntityTypes\`  

- includeEntityTypes:

  a list of entity types to include in the view. Supported entity types
  are:  
  EntityViewType\$FILE,  
  EntityViewType\$PROJECT,  
  EntityViewType\$TABLE,  
  EntityViewType\$FOLDER,  
  EntityViewType\$VIEW,  
  EntityViewType\$DOCKER  
  If none is provided, the view will default to include
  EntityViewType\$FILE.  

- addDefaultViewColumns:

  If true, adds all default columns (e.g. name, createdOn, modifiedBy
  etc.)  
  Defaults to True.  
  The default columns will be added after a call to  
  synapseclient.Synapse.store.  

- addAnnotationColumns:

  If true, adds columns for all annotation keys defined across all
  Entities in  
  the EntityViewSchema's scope. Defaults to True.  
  The annotation columns will be added after a call to  
  synapseclient.Synapse.store.  

- ignoredAnnotationColumnNames:

  A list of strings representing annotation names.  
  When addAnnotationColumns is True, the names in this list will not
  be  
  automatically added as columns to the EntityViewSchema if they exist
  in any  
  of the defined scopes.  

- properties:

  A map of Synapse properties  

- annotations:

  A map of user defined annotations  

## Value

An object of type EntityViewSchema

## Examples

``` r
if (FALSE) { # \dontrun{
project_or_folder <- synGet("syn123")
schema <- EntityViewSchema(name='MyFileView', parent=project, scopes=c(project_or_folder$properties$id, 'syn456'), includeEntityTypes=c(EntityViewType$FILE, EntityViewType$FOLDER))
schema <- synStore(schema)
} # }
```
