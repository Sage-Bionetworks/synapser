# JSONSchema

Represents a [JSON
Schema](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/JsonSchemaInfo.html).

## Usage

``` r
JSONSchema(name=NULL, organization_name=NULL, organization_id=NULL, id=NULL, created_on=NULL, created_by=NULL)
```

## Format

An S3-style class object.

## Arguments

- name:

  (Optional\[character\]) The name of the schema

- organization_name:

  (Optional\[character\]) The name of the organization the schema
  belongs to

- organization_id:

  (Optional\[integer\]) The ID of the organization the schema belongs to

- id:

  (Optional\[character\]) The ID of the schema

- created_on:

  (Optional\[character\]) The date this schema was created

- created_by:

  (Optional\[character\]) The ID of the user that created this schema

## Value

NULL

## Methods

- `JSONSchema(name=NULL, organization_name=NULL, organization_id=NULL, id=NULL, created_on=NULL, created_by=NULL)`:
  Constructor for `JSONSchema`

- [`synFromUri`](https://r-docs.synapse.org/latest/reference/JSONSchema_FromUri.md)`(cls, uri)`:
  Creates a JSONSchema from a URI. The URI can either be a semantic
  version or not:  
  - non-semantic: ORGANIZATION.NAME-SCHEMA.NAME  
  - semantic: ORGANIZATION.NAME-SCHEMA.NAME-MAJOR.MINOR.PATCH

- [`synGetBody`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetBody.md)`(instance, version=NULL, synapse_client=NULL)`:
  Gets the body of this JSONSchema

- [`synGetVersions`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetVersions.md)`(instance, synapse_client=NULL)`:
  Gets all versions of this JSONSchema

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Store a JSON schema
    # This example expects that the organization "my.org" already exists.
    library(synapser)
    synLogin()

    schema_body = list(
        properties = list(
            Component = list(
                description = "TBD",
                not = list(type = "null"),
                title = "Component"
            )
        )
    )
    schema = JSONSchema(organization_name = "my.org", name = "test.schema") |> synStore(
        json_schema_options = StoreJSONSchemaOptions(schema_body = schema_body, version = "0.0.1")
    )

## Example 2: Get an existing JSON schema
    schema = JSONSchema(organization_name = "my.org", name = "test.schema") |> synGet()
    print(schema$uri)

## Example 3: Create a JSON schema from a URI
    schema = JSONSchema |> synFromUri(uri = "my.org-test.schema")

## Example 4: Get the body of a JSON schema
    # Get the latest version
    latest = schema |> synGetBody()
    print(latest)

    # Get a specific version
    first = schema |> synGetBody(version = "0.0.1")
    print(first)

## Example 5: Get all versions of a JSON schema
    for (item in as.list(schema |> synGetVersions())) {
        print(item)
    }

## Example 6: Delete a JSON schema
    # Delete a specific version
    schema |> synDelete(version = "0.0.1")

    # Or delete the whole schema
    schema |> synDelete()
} # }
```
