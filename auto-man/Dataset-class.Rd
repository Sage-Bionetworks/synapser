%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Dataset-class}
\alias{Dataset-class}
\docType{class}
\title{
Dataset
}
\format{An R6 class object.}
\description{
A Dataset is an [Entity][synapseclient.entity.Entity] that defines a
flat list of entities as a tableview (a.k.a. a "dataset").

Attributes:
    name:          The name for the Dataset object
    description:   User readable description of the schema
    columns:       A list of [Column][synapseclient.table.Column] objects or their IDs
    parent:        The Synapse Project to which this Dataset belongs
    properties:    A map of Synapse properties
    annotations:   A map of user defined annotations
    dataset_items: A list of items characterized by entityId and versionNumber
    folder:        A list of Folder IDs
    local_state:   Internal use only
}
\section{Methods}{
\itemize{
\item \code{Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE)}: Constructor for \code{\link{Dataset}}
\item \code{addColumn(column)}: Store the column\cr
\cr
Arguments:\cr
    column: A column object or its ID\cr
\cr
Raises:\cr
    ValueError: If the given column is not a string, integer or [Column][synapseclient.table.Column] object
\item \code{addColumns(columns)}: Add columns\cr
\cr
Arguments:\cr
    columns: A list of column objects or their ID
\item \code{add_folder(folder, force=TRUE)}: Add a folder\cr
\cr
Arguments:\cr
    folder: A single Synapse Folder ID\cr
    force:  Force add items from folder
\item \code{add_folders(folders, force=TRUE)}: Add folders\cr
\cr
Arguments:\cr
    folders: A list of Synapse Folder IDs\cr
    force:   Force add items from folders
\item \code{add_item(dataset_item, force=TRUE)}: Add a dataset item\cr
\cr
Arguments:\cr
    dataset_item: A single dataset item\cr
    force:        Force add item\cr
\cr
Raises:\cr
    ValueError: If duplicate item is found\cr
    ValueError: The item is not a DatasetItem
\item \code{add_items(dataset_items, force=TRUE)}: Add items\cr
\cr
Arguments:\cr
    dataset_items: A list of dataset items\cr
    force:         Force add items
\item \code{add_scope(entities)}: Add scope\cr
\cr
Arguments:\cr
    entities: A [Project][synapseclient.entity.Project], [Folder][synapseclient.entity.Folder],\cr
              [Evaluation][synapseclient.evaluation.Evaluation] object or its ID, can also be a list of them
\item \code{empty()}: 
\item \code{has_columns()}: Does this schema have columns specified?
\item \code{has_item(item_id)}: Check if has dataset item\cr
\cr
Arguments:\cr
    item_id: A single dataset item Synapse ID
\item \code{removeColumn(column)}: Remove column\cr
\cr
Arguments:\cr
    column: A column object or its ID\cr
\cr
Raises:\cr
    ValueError: If the given column is not a string, integer or [Column][synapseclient.table.Column] object
\item \code{remove_item(item_id)}: Remove item\cr
\cr
Arguments:\cr
    item_id: A single dataset item Synapse ID
}
}

