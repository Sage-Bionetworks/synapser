# Agent : get_session

Gets an existing agent session. Adds the session to the Agent's sessions
named list and sets it as the current session.

## Usage

``` r
synGetSession(instance, session_id, synapse_client=NULL)
```

## Arguments

- instance:

  (Agent) The Agent instance to operate on.

- session_id:

  (str) The ID of the session to get.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The existing AgentSession object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get an existing session and send a prompt.
    # Retrieve an existing session by providing the session ID and calling synGetSession().
    # Then, send a prompt to the agent.
    library(synapser)
    synLogin()

    my_session = Agent() |> synGetSession(session_id = "foo")
    my_session |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
} # }
```
