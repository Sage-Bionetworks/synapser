# UserPreference

A UserPreference represents a user preference in the system.

## Usage

``` r
UserPreference(name=NULL, value=NULL)
```

## Format

An S3-style class object.

## Arguments

- name:

  (Optional\[str\]) The name of the user preference.

- value:

  (Optional\[bool\]) The value of the user preference.

## Value

NULL

## Methods

- `UserPreference(name=NULL, value=NULL)`: Constructor for
  `UserPreference`

## Examples

``` r
if (FALSE) { # \dontrun{
## Inspecting a user's preferences
    # UserPreference objects are found in the `preferences` field of a UserProfile
    library(synapser)
    synLogin()

    profile = UserProfile |> synGetFromUsername(username = "myUsername")
    for (preference in profile$preferences) {
        print(sprintf("%s: %s", preference$name, preference$value))
    }
} # }
```
