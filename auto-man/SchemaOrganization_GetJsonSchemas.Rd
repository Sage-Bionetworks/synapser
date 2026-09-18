%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetJsonSchemas}
\alias{synGetJsonSchemas}
\docType{methods}
\title{
SchemaOrganization :  get_json_schemas
}
\description{
Gets the JSON Schemas that are part of this organization
}
\usage{
synGetJsonSchemas(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(SchemaOrganization) The SchemaOrganization instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor}
}
\value{
A Generator containing the JSONSchemas that belong to this organization
}
\examples{
\dontrun{
## Get the JSONSchemas that are part of this SchemaOrganization

    from synapseclient.models import SchemaOrganization
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()

    org = SchemaOrganization("dpetest")
    js_generator = org.get_json_schemas()
    for item in js_generator:
        print(item)
}
}
\keyword{SchemaOrganization}
