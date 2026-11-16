# AgentSession : update

Updates an agent session. Only updates to the access level are currently
supported.

## Usage

``` r
synUpdate(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (AgentSession) The AgentSession instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The updated AgentSession object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Update the access level of an existing session.
    # Construct an AgentSession with its session ID, set the access level you
    # want, and call synUpdate().
    library(synapser)
    synLogin()

    my_session = AgentSession(id = "foo")
    my_session$access_level = "READ_YOUR_PRIVATE_DATA"
    my_session = my_session |> synUpdate()
} # }
```
