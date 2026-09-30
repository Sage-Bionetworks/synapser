\name{synUpdate}
\alias{AgentSession_synUpdate}
\docType{methods}
\title{
AgentSession :  update
}
\description{
Updates an agent session.
Only updates to the access level are currently supported.
}
\usage{
synUpdate(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(AgentSession) The AgentSession instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The updated AgentSession object.
}
\examples{
\dontrun{
## Update the access level of an existing session.
    # Construct an AgentSession with its session ID, set the access level you
    # want, and call synUpdate().
    library(synapser)
    synLogin()

    my_session = AgentSession(id = "foo")
    my_session$access_level = "READ_YOUR_PRIVATE_DATA"
    my_session = my_session |> synUpdate()
}
}
\keyword{AgentSession}
