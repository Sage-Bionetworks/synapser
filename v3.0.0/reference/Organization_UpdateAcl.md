# Organization : update_acl

Updates the ACL for a principal for this organization

## Usage

``` r
synUpdateAcl(instance, principal_id, access_type, synapse_client=NULL)
```

## Arguments

- instance:

  (Organization) The Organization instance to operate on.

- principal_id:

  (integer) the id of the principal whose permissions are to be updated

- access_type:

  (list\[character\]) List of permission types (e.g., list("READ",
  "CREATE", "DELETE")) see:
  [ACCESS_TYPE](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html)

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Examples

``` r
if (FALSE) { # \dontrun{
## Update the ACL for a Organization
    library(synapser)
    synLogin()

    org = Organization(name = "dpetest")
    org |> synUpdateAcl(
        principal_id = 1L,
        access_type = list("READ")
    )
} # }
```
