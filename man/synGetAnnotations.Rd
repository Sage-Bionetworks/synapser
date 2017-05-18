\name{synGetAnnotations}
\alias{synGetAnnotations}
\docType{methods}
\title{
synGetAnnotations
}
\description{}
\usage{
	synGetAnnotations()
}
\arguments{

}
\details{
Retrieve annotations for an Entity from the Synapse Repository as a Python dict.

Note that collapsing annotations from the native Synapse format to a Python dict
may involve some loss of information. See :py:func:`_getRawAnnotations` to get
annotations in the native format.

:param entity:  An Entity or Synapse ID to lookup
:param version: The version of the Entity to retrieve.

:returns: A dictionary
}

