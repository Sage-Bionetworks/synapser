%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetClient}
\alias{synGetClient}
\docType{methods}
\title{
synGetClient
}
\description{
Convience function to get an instance of 'Synapse'. The latest instance created
by 'login()' or set via `set_client` will be returned.

When 'logout()' is called it will delete the instance.

Arguments:
    synapse_client: An instance of 'Synapse' or None. This is used to simplify logical checks
            in cases where synapse is passed into them.

Returns:
    An instance of 'Synapse'.

Raises:
    SynapseError: No instance has been created - Please use login() first
}
\usage{
synGetClient(synapse_client)
}
\arguments{
\item{synapse_client}{}
}
\value{

}


