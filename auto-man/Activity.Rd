%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Activity}
\alias{Activity}
\docType{methods}
\title{
Constructor for objects of type Activity
}
\description{
Represents the provenance of a Synapse Entity.
}
\usage{
Activity(name=NULL, description=NULL, used=NULL, executed=NULL, data=list())
}
\arguments{
\item{name}{        name of the Activity\cr
}
\item{description}{ a short text description of the Activity\cr
}
\item{used}{        Either a list of:}
\item{executed}{    A code resource that was executed to generate the Entity.\cr
}
\item{data}{        A dictionary representation of an Activity, with fields 'name', 'description' and 'used'\cr
                    (a list of reference objects)}
}
\value{
An object of type Activity
}


