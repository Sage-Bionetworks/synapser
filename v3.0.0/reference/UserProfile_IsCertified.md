# UserProfile : is_certified

Determine whether a user is certified.

## Usage

``` r
synIsCertified(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (UserProfile) The UserProfile instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

TRUE if the user is certified, FALSE otherwise.

## Errors

An error is raised if neither id nor username is specified.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Check whether a user is certified
    is_certified = UserProfile(username = "myUsername") |> synIsCertified()
} # }
```
