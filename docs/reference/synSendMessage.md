# synSendMessage

send a message via Synapse.

## Usage

``` r
synSendMessage(userIds, messageSubject, messageBody, contentType = "text/plain")
```

## Arguments

- userIds:

  A list of user IDs to which the message is to be sent

- messageSubject:

  The subject for the message

- messageBody:

  The body of the message

- contentType:

  optional contentType of message body (default="text/plain")  
  Should be one of "text/plain" or "text/html"

## Value

The metadata of the created message

## Examples

``` r
if (FALSE) { # \dontrun{
synSendMessage(userIds = list("3321601"), messageSubject = "Test message", messageBody = "Hello")
} # }
```
