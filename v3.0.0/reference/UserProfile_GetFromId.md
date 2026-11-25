# UserProfile : from_id

Gets UserProfile object using its integer id.

## Usage

``` r
synGetFromId(cls, user_id, synapse_client=NULL)
```

## Arguments

- cls:

  (UserProfile) The UserProfile class (or an existing UserProfile
  instance) to dispatch this call to.

- user_id:

  (int) The id of the user.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The UserProfile object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Assuming you know the integer ID of a Synapse user:
    user_profile = UserProfile |> synGetFromId(user_id = 273948L)
} # }
```
