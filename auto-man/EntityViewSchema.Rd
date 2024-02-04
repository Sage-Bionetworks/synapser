%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{EntityViewSchema}
\alias{EntityViewSchema}
\docType{methods}
\title{
Constructor for objects of type EntityViewSchema
}
\description{
A EntityViewSchema is a [Entity][synapseclient.entity.Entity] that displays all files/projects
(depending on user choice) within a given set of scopes.

Attributes:
    name:                         The name of the Entity View Table object
    columns:                      (Optional) A list of [Column][synapseclient.table.Column] objects or their IDs.
    parent:                       The project in Synapse to which this table belongs
    scopes:                       A list of Projects/Folders or their ids
    type:                         This field is deprecated. Please use `includeEntityTypes`
    includeEntityTypes:           A list of entity types to include in the view. Supported entity types are:

        - `EntityViewType.FILE`
        - `EntityViewType.PROJECT`
        - `EntityViewType.TABLE`
        - `EntityViewType.FOLDER`
        - `EntityViewType.VIEW`
        - `EntityViewType.DOCKER`

        If none is provided, the view will default to include `EntityViewType.FILE`.
    addDefaultViewColumns:        If true, adds all default columns (e.g. name, createdOn, modifiedBy etc.)
                                  Defaults to True.
                                  The default columns will be added after a call to
                                  [store][synapseclient.Synapse.store].
    addAnnotationColumns:         If true, adds columns for all annotation keys defined across all Entities in
                                  the EntityViewSchema's scope. Defaults to True.
                                  The annotation columns will be added after a call to
                                  [store][synapseclient.Synapse.store].
    ignoredAnnotationColumnNames: A list of strings representing annotation names.
                                  When addAnnotationColumns is True, the names in this list will not be
                                  automatically added as columns to the EntityViewSchema if they exist in any
                                  of the defined scopes.
    properties:                   A map of Synapse properties
    annotations:                  A map of user defined annotations
    local_state:                  Internal use only
}
\usage{
EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, includeEntityTypes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{}
\item{columns}{}
\item{parent}{}
\item{scopes}{}
\item{type}{}
\item{includeEntityTypes}{}
\item{addDefaultViewColumns}{}
\item{addAnnotationColumns}{}
\item{ignoredAnnotationColumnNames}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type EntityViewSchema
}

 
\examples{
%\dontrun{
%    from synapseclient import EntityViewType
%}
}
