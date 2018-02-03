%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{File}
\alias{File}
\docType{methods}
\title{
Constructor for objects of type File
}
\description{
Represents a file in Synapse.

When a File object is stored, the associated local file or its URL will be
stored in Synapse. A File must have a path (or URL) and a parent.
}
\usage{
File(path=NULL, parent=NULL, synapseStore=TRUE, properties=NULL, annotations=NULL, local_state=NULL, name=NULL, contentType=NULL, dataFileHandleId=NULL)
}
\arguments{
\item{path}{             Location to be represented by this File\cr
}
\item{parent}{           Project or Folder where this File is stored\cr
}
\item{synapseStore}{     Whether the File should be uploaded or if only the path should be stored when synStore \cr
                        is called on the File object. Defaults to True (file should be uploaded)\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
\item{name}{optional named parameter:              Name of the file in Synapse, not to be confused with the name within the path\cr
}
\item{contentType}{optional named parameter:       Manually specify Content-type header, for example "application/png" or "application/json; charset=UTF-8"\cr
}
\item{dataFileHandleId}{optional named parameter:  Defining an existing dataFileHandleId will use the existing dataFileHandleId\cr
                         The creator of the file must also be the owner of the dataFileHandleId to have permission to store the file\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type File
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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{
%\dontrun{
%    data = File('/path/to/file/data.xyz', parent=folder)
%    data = syn.store(data)
%}
}



