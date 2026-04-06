# synCreateTeam

Creates a new team

## Usage

``` r
synCreateTeam(name, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE)
```

## Arguments

- name:

  The name of the team to create.

- description:

  A description of the team.

- icon:

  The FileHandleID of the icon to be used for the team.

- can_public_join:

  Whether the team can be joined by anyone. Defaults to FALSE.

- can_request_membership:

  Whether the team can request membership. Defaults to TRUE.

## Value

An Team object

## Examples

``` r
if (FALSE) { # \dontrun{
synCreateTeam('your_team_name')
} # }
```
