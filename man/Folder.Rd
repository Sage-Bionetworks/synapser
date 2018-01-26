\name{Folder}
\alias{Folder}
\docType{methods}
\title{
Constructor for objects of type Folder
}
\description{
Represents a folder in Synapse.

Folders must have a name and a parent and can optionally have annotations.
}
\usage{
Folder(name=NULL, parent=NULL, annotations=NULL)
}
\arguments{
\item{name}{            The name of the folder\cr
}
\item{parent}{          The parent project or folder\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Folder
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
folder <- Folder('my data', parent=project, annotations=c(foo='bar', bat=101))
folder <- synStore(folder)
folder$annotations$foo
}
}



