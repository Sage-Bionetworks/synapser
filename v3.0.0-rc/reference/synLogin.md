# synLogin

Valid combinations of synLogin() arguments:

\- authToken\
\- Profile-based authentication (from .synapseConfig)

If no login arguments are provided or only username is provided,
synLogin() will attempt to log in using information from these sources
(in order of preference):

1\. .synapseConfig file (supports multiple profiles)(in user home folder
unless configured otherwise)\
2\. User defined arguments during a CLI session\
3\. User's Personal Access Token (aka: Synapse Auth Token) from the
environment variable: SYNAPSE_AUTH_TOKEN\
4\. Retrieves user's authentication token from AWS SSM Parameter store
(if configured)

## Usage

``` r
synLogin(email=NULL, silent=FALSE, authToken=NULL, profile="default")
```

## Arguments

- email:

  (str) Synapse user name (or an email address associated with a Synapse
  account)

- silent:

  (bool) Defaults to FALSE. Suppresses the "Welcome ...!" message.

- authToken:

  (str) A bearer authorization token, e.g. a [personal access
  token](https://r-docs.synapse.org/articles/authentication.html).

- profile:

  (str) Profile to use from .synapseConfig (default: "default").

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Logging in
    library(synapser)

    # Logging in using a specific profile:
    synLogin(profile = "user1")
    # Prints: Welcome, username! You are using the user1 profile

    # Logging in with an authentication token:
    synLogin(authToken = "your_auth_token")
    # Prints: Welcome, username!
} # }
```
