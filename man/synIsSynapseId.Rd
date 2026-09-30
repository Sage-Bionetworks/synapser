\name{synIsSynapseId}
\alias{synIsSynapseId}
\docType{methods}
\title{
synIsSynapseId
}
\description{
Check if given synID is valid (attached to actual entity).
}
\usage{
synIsSynapseId(syn_id, synapse_client=NULL)
}
\arguments{
\item{syn_id}{(str) A Synapse ID to validate.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
TRUE if the Synapse ID is valid.
}
\examples{
\dontrun{
## Example 1: Validating a Synapse ID
    # Check if a Synapse ID exists:
    library(synapser)
    synLogin()

    if (synIsSynapseId("syn123456")) {
        print("Valid Synapse ID")
    } else {
        print("Invalid or non-existent Synapse ID")
    }

## Example 2: Validating multiple IDs
    # Check multiple Synapse IDs in a loop:
    library(synapser)
    synLogin()

    ids_to_check = list("syn123456", "syn999999", "syn789012")
    for (synapse_id in ids_to_check) {
        if (synIsSynapseId(synapse_id)) {
            print(sprintf("\%s is valid", synapse_id))
        } else {
            print(sprintf("\%s is invalid or does not exist", synapse_id))
        }
    }

## Example 3: Using in conditional logic
    # Use ID validation before attempting operations:
    library(synapser)
    synLogin()

    user_input = "syn123456"
    if (synIsSynapseId(user_input)) {
        entity = synGet(synapse_id = user_input)
        print(sprintf("Retrieved entity: \%s", entity$name))
    } else {
        print("Please provide a valid Synapse ID")
    }
}
}
