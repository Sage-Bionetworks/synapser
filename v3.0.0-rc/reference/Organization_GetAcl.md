# Organization : get_acl

Gets the ACL for this organization

## Usage

``` r
synGetAcl(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Organization) The Organization instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A named list in the form of this response:
[AccessControlList](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html)

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the ACL for a Organization
    library(synapser)
    synLogin()

    org = Organization(name = "dpetest")
    acl = org |> synGetAcl()

    etag = acl[["etag"]]
    print(etag)
    resource_access = acl[["resourceAccess"]]
    for (item in resource_access) {
        principal_id = item[["principalId"]]
        print(principal_id)
        access_types = item[["accessType"]]
        print(access_types)
    }
} # }
```
