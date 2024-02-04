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

Parameters:
    name: Name of the Activity
    description: A short text description of the Activity
    used: Either a list of:

        - [reference objects](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Reference.html) (e.g. [{'targetId':'syn123456', 'targetVersionNumber':1}])
        - a list of Synapse Entities or Entity IDs
        - a list of URL's
    executed: A code resource that was executed to generate the Entity.
    data: A dictionary representation of an Activity, with fields 'name', 'description' and 'used' (a list of reference objects)

See also: The [W3C's provenance ontology](http://www.w3.org/TR/prov-o/)
}
\usage{
Activity(name=NULL, description=NULL, used=NULL, executed=NULL, data=list())
}
\arguments{
\item{name}{}
\item{description}{}
\item{used}{}
\item{executed}{}
\item{data}{}
}
\value{
An object of type Activity
}


