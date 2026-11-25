# UserProfile : from_username

Gets UserProfile object using its string name.

## Usage

``` r
synGetFromUsername(cls, username, synapse_client=NULL)
```

## Arguments

- cls:

  (UserProfile) The UserProfile class (or an existing UserProfile
  instance) to dispatch this call to.

- username:

  (str) A name chosen by the user that uniquely identifies them.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The UserProfile object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you know the username of a Synapse user:
    user_profile = UserProfile |> synGetFromUsername(username = "myUsername")
} # }
```
