# Agent : get_chat_history

Gets the chat history for the current session.

## Usage

``` r
synGetChatHistory(instance)
```

## Arguments

- instance:

  (Agent) The Agent instance to operate on.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the chat history for the current session.
    # First, send a prompt to the agent.
    # Then, retrieve the chat history for the current session by calling synGetChatHistory().
    library(synapser)
    synLogin()

    my_agent = Agent()
    my_agent |> synPrompt(
        prompt = "Hello",
        enable_trace = TRUE,
        print_response = TRUE
    )
    print(my_agent |> synGetChatHistory())
} # }
```
