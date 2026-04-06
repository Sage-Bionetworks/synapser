# synGetPermissions

Get the permissions that a user or group has on an Entity.

## Usage

``` r
synGetPermissions(entity, principalId=NULL)
```

## Arguments

- entity:

  An Entity or Synapse ID to lookup  

- principalId:

  Identifier of a user or group (defaults to PUBLIC users)

## Value

An array containing some combination of \['READ', 'CREATE', 'UPDATE',
'DELETE', 'CHANGE_PERMISSIONS', 'DOWNLOAD'\] or an empty array

## Examples

``` r
if (FALSE) { # \dontrun{
synGetPermissions("syn11705401", "3320560")
} # }
```
