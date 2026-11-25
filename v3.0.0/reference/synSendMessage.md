# synSendMessage

Send a message via Synapse.

## Usage

``` r
synSendMessage(userIds, messageSubject, messageBody, contentType="text/plain")
```

## Arguments

- userIds:

  A list of user IDs to which the message is to be sent

- messageSubject:

  The subject for the message

- messageBody:

  The body of the message

- contentType:

  optional contentType of message body (default="text/plain") Should be
  one of "text/plain" or "text/html"

## Value

The metadata of the created message

## Examples

``` r
if (FALSE) { # \dontrun{
## Sending a message
    library(synapser)
    synLogin()

    message = synSendMessage(
        userIds = list(273948L),
        messageSubject = "Data is ready",
        messageBody = "The analysis results have been uploaded to syn123."
    )

    # Send an HTML message
    message = synSendMessage(
        userIds = list(273948L),
        messageSubject = "Data is ready",
        messageBody = "<p>The results are in <b>syn123</b>.</p>",
        contentType = "text/html"
    )
} # }
```
