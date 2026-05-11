%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synAllowClientCaching}
\alias{synAllowClientCaching}
\docType{methods}
\title{
synAllowClientCaching
}
\description{
Allows for a global setting to enable or disable caching of the Synapse
client object. **If you are working in a multi-user environment you should set
this to False to prevent any possibility of picking up another user session.**


As a consequence of setting this to false you must pass a Synapse class instance
to any function, method, or class that requires it - If if it is marked as
`Optional`.
}
\usage{
synAllowClientCaching(allow_client_caching)
}
\arguments{
\item{allow_client_caching}{}
}
\value{

}


