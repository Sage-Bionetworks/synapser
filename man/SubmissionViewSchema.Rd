\name{SubmissionViewSchema}
\alias{SubmissionViewSchema}
\docType{methods}
\title{
Constructor for objects of type SubmissionViewSchema
}
\description{
A SubmissionViewSchema is a Entity that displays all files/projects
(depending on user choice) within a given set of scopes
}
\usage{
SubmissionViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{                            the name of the Entity View Table object\cr
}
\item{columns}{                         a list of Column objects or their IDs. These are optional.\cr
}
\item{parent}{                          the project in Synapse to which this table belongs\cr
}
\item{scopes}{                          a list of Evaluation Queues or their ids\cr
}
\item{addDefaultViewColumns}{           If true, adds all default columns (e.g. name, createdOn, modifiedBy etc.)\cr
                                        Defaults to True.\cr
                                        The default columns will be added after a call to\cr
                                        synapseclient.Synapse.store.\cr
}
\item{addAnnotationColumns}{            If true, adds columns for all annotation keys defined across all Entities in\cr
                                        the SubmissionViewSchema's scope. Defaults to True.\cr
                                        The annotation columns will be added after a call to\cr
                                        synapseclient.Synapse.store.\cr
}
\item{ignoredAnnotationColumnNames}{    A list of strings representing annotation names.\cr
                                        When addAnnotationColumns is True, the names in this list will not be\cr
                                        automatically added as columns to the SubmissionViewSchema if they exist in\cr
                                        any of the defined scopes.\cr
}
\item{properties}{                      A map of Synapse properties\cr
}
\item{annotations}{                     A map of user defined annotations\cr
}
\item{local_state}{                     Internal use only}
}
\value{
An object of type SubmissionViewSchema
}


