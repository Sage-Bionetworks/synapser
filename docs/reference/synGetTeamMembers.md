# synGetTeamMembers

Lists the members of the given team.

## Usage

``` r
synGetTeamMembers(team)
```

## Arguments

- team:

  A Team object or a team's ID.

## Value

a generator over TeamMember objects. Use
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  teamMembers<-synGetTeamMembers(3324324)
} # }
```
