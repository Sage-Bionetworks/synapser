# AgentSession : start

Starts an agent session.

## Usage

``` r
synStart(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (AgentSession) The AgentSession instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The new AgentSession object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Start a session and send a prompt.
    # Start a session with a custom agent by providing the agent's registration ID
    # and calling synStart(). Then, send a prompt to the agent.
    library(synapser)
    synLogin()

    my_session = AgentSession(agent_registration_id = "foo") |> synStart()
    my_session |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
} # }
```
