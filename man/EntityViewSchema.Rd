\name{EntityViewSchema}
\alias{EntityViewSchema}
\docType{methods}
\title{
Constructor for objects of type EntityViewSchema
}
\description{
A EntityViewSchema is a Entity that displays all files/projects (depending on user choice) within a given set of scopes
}
\usage{
EntityViewSchema(name=NULL, columns=NULL, parent=NULL, scopes=NULL, type=NULL, includeEntityTypes=NULL, addDefaultViewColumns=TRUE, addAnnotationColumns=TRUE, ignoredAnnotationColumnNames=list(), properties=NULL, annotations=NULL)
}
\arguments{
\item{name}{                            the name of the Entity View Table object\cr
}
\item{columns}{                         a list of Column objects or their IDs. These are optional.\cr
}
\item{parent}{                          the project in Synapse to which this table belongs\cr
}
\item{scopes}{                          a list of Projects/Folders or their ids\cr
}
\item{type}{                            This field is deprecated. Please use `includeEntityTypes`\cr
}
\item{includeEntityTypes}{              a list of entity types to include in the view. Supported entity types are:\cr
                                            EntityViewType$FILE,\cr
                                            EntityViewType$PROJECT,\cr
                                            EntityViewType$TABLE,\cr
                                            EntityViewType$FOLDER,\cr
                                            EntityViewType$VIEW,\cr
                                            EntityViewType$DOCKER\cr
                                        If none is provided, the view will default to include EntityViewType$FILE.\cr
}
\item{addDefaultViewColumns}{           If true, adds all default columns (e.g. name, createdOn, modifiedBy etc.)\cr
                                        Defaults to True.\cr
                                        The default columns will be added after a call to\cr
                                        synapseclient.Synapse.store.\cr
}
\item{addAnnotationColumns}{            If true, adds columns for all annotation keys defined across all Entities in\cr
                                        the EntityViewSchema's scope. Defaults to True.\cr
                                        The annotation columns will be added after a call to\cr
                                        synapseclient.Synapse.store.\cr
}
\item{ignoredAnnotationColumnNames}{    A list of strings representing annotation names.\cr
                                        When addAnnotationColumns is True, the names in this list will not be\cr
                                        automatically added as columns to the EntityViewSchema if they exist in any\cr
                                        of the defined scopes.\cr
}
\item{properties}{                      A map of Synapse properties\cr
}
\item{annotations}{                     A map of user defined annotations\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type EntityViewSchema
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
%
% Verified that the following works on 2018Jan23.
% 
\examples{
\dontrun{
project_or_folder <- synGet("syn123")  
schema <- EntityViewSchema(name='MyFileView', parent=project, scopes=c(project_or_folder$properties$id, 'syn456'), includeEntityTypes=c(EntityViewType$FILE, EntityViewType$FOLDER))
schema <- synStore(schema)
}
}



