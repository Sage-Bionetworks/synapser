\name{Link}
\alias{Link}
\docType{methods}
\title{
Constructor for objects of type Link
}
\description{
Represents a link in Synapse.

Links must have a target ID and a parent. When you do synGet on a Link object,
the Link object is returned. If the target is desired, specify followLink=TRUE in synGet().
}
\usage{
Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL)
}
\arguments{
\item{targetId}{        The ID of the entity to be linked\cr
}
\item{targetVersion}{   The version of the entity to be linked\cr
}
\item{parent}{          The parent project or folder\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
}
\value{
An object of type Link
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
# create a link to 'syn1234567' under some other folder
link <- Link('syn1234567', parent=folder)
link <- synStore(link)
}
}



