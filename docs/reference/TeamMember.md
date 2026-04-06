# Constructor for objects of type TeamMember

Contains information about a user's membership in a Team. In practice
the constructor is not called directly by the client.

## Usage

``` r
TeamMember(teamId=NULL, member=NULL, isAdmin=NULL)
```

## Arguments

- teamId:

  optional named parameter: the ID of the team  

- member:

  optional named parameter: An object of type UserGroupHeader describing
  the member  

- isAdmin:

  optional named parameter: Whether the given member is an administrator
  of the team

## Value

An object of type TeamMember
