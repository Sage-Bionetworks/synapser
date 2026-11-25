# Agent : register

Registers an agent with the Synapse API. If agent already exists, it
will be retrieved.

## Usage

``` r
synRegister(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Agent) The Agent instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The registered or existing Agent object.

## Examples

``` r
if (FALSE) { # \dontrun{
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
} # }
```
