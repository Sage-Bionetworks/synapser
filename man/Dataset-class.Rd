\name{Dataset-class}
\alias{Dataset-class}
\docType{class}
\title{
Dataset
}
\format{An R6 class object.}
\description{
A Dataset is an Entity that defines a
flat list of entities as a tableview (a.k.a. a "dataset").
}
\section{Methods}{
\itemize{
\item \code{Dataset(name=NULL, columns=NULL, parent=NULL, properties=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), annotations=NULL, local_state=NULL, dataset_items=NULL, folders=NULL, force=FALSE, description=NULL, folder=NULL)}: Constructor for \code{\link{Dataset}}
\item \code{addColumn(column)}:
\item \code{addColumns(columns)}:
\item \code{add_folder(folder, force=TRUE)}:
\item \code{add_folders(folders, force=TRUE)}:
\item \code{add_item(dataset_item, force=TRUE)}:
\item \code{add_items(dataset_items, force=TRUE)}:
\item \code{add_scope(entities)}:
\item \code{empty()}:
\item \code{has_columns()}: Does this schema have columns specified?
\item \code{has_item(item_id)}:
\item \code{removeColumn(column)}:
\item \code{remove_item(item_id)}:
}
}

