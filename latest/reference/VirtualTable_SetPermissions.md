# VirtualTable : set_permissions

Sets permission that a user or group has on an Entity. An Entity may
have its own ACL or inherit its ACL from a benefactor.

## Usage

``` r
synSetPermissions(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)
```

## Arguments

- instance:

  (VirtualTable) The VirtualTable instance to operate on.

- principal_id:

  (int) Identifier of a user or group. `273948` is for all registered
  Synapse users and `273949` is for public access. NULL implies public
  access.

- access_type:

  (list\[str\]) Type of permission to be granted. One or more of CREATE,
  READ, DOWNLOAD, UPDATE, DELETE, CHANGE_PERMISSIONS.  
    
  **Defaults to list("READ", "DOWNLOAD")**

- modify_benefactor:

  (bool) Set as TRUE when modifying a benefactor's ACL. The term
  'benefactor' is used to indicate which Entity an Entity inherits its
  ACL from. For example, a newly created Project will be its own
  benefactor, while a new FileEntity's benefactor will start off as its
  containing Project. If the entity already has local sharing settings
  the benefactor would be itself. It may also be the immediate parent,
  somewhere in the parent tree, or the project itself.

- warn_if_inherits:

  (bool) When `modify_benefactor` is TRUE, this does not have any
  effect. When `modify_benefactor` is FALSE, and `warn_if_inherits` is
  TRUE, a warning log message is produced if the benefactor for the
  entity you passed into the function is not itself, i.e., it's the
  parent folder, or another entity in the parent tree.

- overwrite:

  (bool) By default this function overwrites existing permissions for
  the specified user. Set this flag to FALSE to add new permissions
  non-destructively.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

An Access Control List object matching
\<https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html\>.

## Examples

``` r
if (FALSE) { # \dontrun{
## Setting permissions
    # Grant all registered users download access
    library(synapser)
    synLogin()

    VirtualTable(id = "syn123") |> synSetPermissions(principal_id = 273948L, access_type = list("READ", "DOWNLOAD"))

    # Grant the public view access
    VirtualTable(id = "syn123") |> synSetPermissions(principal_id = 273949L, access_type = list("READ"))
} # }
```
