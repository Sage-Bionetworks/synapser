%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
True if the Synapse ID is valid.
}
\examples{
\dontrun{
## Example 1: Validating a Synapse ID
    # Check if a Synapse ID exists:

    from synapseclient import Synapse
    from synapseclient.operations import is_synapse_id

    syn = Synapse()
    syn.login()

    if is_synapse_id("syn123456"):
        print("Valid Synapse ID")
    else:
        print("Invalid or non-existent Synapse ID")

## Example 2: Validating multiple IDs
    # Check multiple Synapse IDs in a loop:

    from synapseclient import Synapse
    from synapseclient.operations import is_synapse_id

    syn = Synapse()
    syn.login()

    ids_to_check = ["syn123456", "syn999999", "syn789012"]
    for synapse_id in ids_to_check:
        if is_synapse_id(synapse_id):
            print(f"{synapse_id} is valid")
        else:
            print(f"{synapse_id} is invalid or does not exist")

## Example 3: Using in conditional logic
    # Use ID validation before attempting operations:

    from synapseclient import Synapse
    from synapseclient.operations import is_synapse_id, get

    syn = Synapse()
    syn.login()

    user_input = "syn123456"
    if is_synapse_id(user_input):
        entity = get(synapse_id=user_input)
        print(f"Retrieved entity: {entity.name}")
    else:
        print("Please provide a valid Synapse ID")
}
}
\keyword{}
