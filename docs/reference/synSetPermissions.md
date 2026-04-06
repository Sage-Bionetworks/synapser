# synSetPermissions

Sets permission that a user or group has on an Entity. An Entity may
have its own ACL or inherit its ACL from a benefactor.

## Usage

``` r
synSetPermissions(entity, principalId=NULL, accessType=list("READ", "DOWNLOAD"), modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE)
```

## Arguments

- entity:

  An Entity or Synapse ID to modify  

- principalId:

  Identifier of a user or group. '273948' is for all registered Synapse
  users and '273949' is for public access. None implies public access.  

- accessType:

  Type of permission to be granted. One or more of CREATE, READ,
  DOWNLOAD, UPDATE, DELETE, CHANGE_PERMISSIONS  

- modify_benefactor:

  Set as TRUE when modifying a benefactor's ACL  

- warn_if_inherits:

  Set as FALSE, when creating a new ACL. Trying to modify the ACL of an
  Entity that inherits its ACL will result in a warning

- overwrite:

  By default this function overwrites existing permissions for the
  specified user. Set this flag to FALSE to add new permissions
  non-destructively.

## Value

An Access Control List object

## Examples

``` r
if (FALSE) { # \dontrun{
# assign the Public group "can read"" permission to the entity
synSetPermissions("entity_id", 273949, list("READ"))
} # }
```
