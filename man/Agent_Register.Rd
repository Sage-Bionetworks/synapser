\name{synRegister}
\alias{Agent_synRegister}
\docType{methods}
\title{
Agent :  register
}
\description{
Registers an agent with the Synapse API.
If agent already exists, it will be retrieved.
}
\usage{
synRegister(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Agent) The Agent instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The registered or existing Agent object.
}
\examples{
\dontrun{
## Register and chat with a custom agent
    # Only available for internal users (Sage Bionetworks employees).
    #
    # Alternatively, you can register a custom agent and chat with it provided
    # you have already created it.
    library(synapser)
    synLogin()

    my_agent = Agent(cloud_agent_id = "foo") |> synRegister()
    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
}
}
\keyword{Agent}
