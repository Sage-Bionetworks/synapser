# Organization

Represents an
[Organization](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/Organization.html).

## Usage

``` r
Organization(name=NULL, id=NULL, created_on=NULL, created_by=NULL)
```

## Format

An S3-style class object.

## Arguments

- name:

  (Optional\[character\]) The name of the organization

- id:

  (Optional\[character\]) The ID of the organization

- created_on:

  (Optional\[character\]) The date this organization was created

- created_by:

  (Optional\[character\]) The ID of the user that created this
  organization

## Value

NULL

## Methods

- `Organization(name=NULL, id=NULL, created_on=NULL, created_by=NULL)`:
  Constructor for `Organization`

- [`synGetAcl`](https://r-docs.synapse.org/latest/reference/Organization_GetAcl.md)`(instance, synapse_client=NULL)`:
  Gets the ACL for this organization

- [`synGetJsonSchemas`](https://r-docs.synapse.org/latest/reference/Organization_GetJsonSchemas.md)`(instance, synapse_client=NULL)`:
  Gets the JSON Schemas that are part of this organization

- [`synUpdateAcl`](https://r-docs.synapse.org/latest/reference/Organization_UpdateAcl.md)`(instance, principal_id, access_type, synapse_client=NULL)`:
  Updates the ACL for a principal for this organization

## Examples

``` r
if (FALSE) { # \dontrun{
## Creating a JSON schema organization
    library(synapser)
    synLogin()

    org = Organization(name = "myUniqueOrgName") |> synStore()
    print(org$id)

    # List the JSON schemas in the organization
    schemas = org |> synGetJsonSchemas()

## Getting an existing JSON schema organization
    library(synapser)
    synLogin()

    org = Organization(name = "myUniqueOrgName") |> synGet()
    print(org$id)
} # }
```
