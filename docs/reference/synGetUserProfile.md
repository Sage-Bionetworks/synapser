# synGetUserProfile

Get the details about a Synapse user. Retrieves information on the
current user if 'id' is omitted.

## Usage

``` r
synGetUserProfile(id=NULL, sessionToken=NULL, refresh=NULL)
```

## Arguments

- id:

  optional named parameter: The 'userId' (aka 'ownerId') of a user or
  the userName  

- sessionToken:

  optional named parameter: The session token to use to find the user
  profile  

- refresh:

  optional named parameter: If set to TRUE will always fetch the data
  from Synape otherwise  
  will use cached information

## Value

The user profile for the user of interest.

## Examples

``` r
if (FALSE) { # \dontrun{
my_profile <- synGetUserProfile()
freds_profile <- synGetUserProfile('fredcommo')
} # }
```
