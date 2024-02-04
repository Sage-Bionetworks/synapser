%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SubmissionViewSchema}
\alias{SubmissionViewSchema}
\docType{methods}
\title{
Constructor for objects of type SubmissionViewSchema
}
\description{
A SubmissionViewSchema is a [Entity][synapseclient.entity.Entity] that displays all files/projects
(depending on user choice) within a given set of scopes.

Attributes:
    name:                         The name of the Entity View Table object
    columns:                      A list of [Column][synapseclient.table.Column] objects or their IDs. These are optional.
    parent:                       The project in Synapse to which this table belongs
    scopes:                       A list of Evaluation Queues or their ids
    addDefaultViewColumns:        If true, adds all default columns (e.g. name, createdOn, modifiedBy etc.)
                                  Defaults to True.
                                  The default columns will be added after a call to
                                  [store][synapseclient.Synapse.store].
    addAnnotationColumns:         If true, adds columns for all annotation keys defined across all Entities in
                                  the SubmissionViewSchema's scope. Defaults to True.
                                  The annotation columns will be added after a call to
                                  [store][synapseclient.Synapse.store].
    ignoredAnnotationColumnNames: A list of strings representing annotation names.
                                  When addAnnotationColumns is True, the names in this list will not be
                                  automatically added as columns to the SubmissionViewSchema if they exist in
                                  any of the defined scopes.
    properties:                   A map of Synapse properties
    annotations:                  A map of user defined annotations
    local_state:                  Internal use only
}
\usage{
SubmissionViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{}
\item{columns}{}
\item{parent}{}
\item{scopes}{}
\item{addDefaultViewColumns}{}
\item{addAnnotationColumns}{}
\item{ignoredAnnotationColumnNames}{}
\item{properties}{}
\item{annotations}{}
\item{local_state}{}
}
\value{
An object of type SubmissionViewSchema
}


