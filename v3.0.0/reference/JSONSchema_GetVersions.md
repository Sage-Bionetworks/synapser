# JSONSchema : get_versions

Gets all versions of this JSONSchema

## Usage

``` r
synGetVersions(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (JSONSchema) The JSONSchema instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields a `JSONSchemaVersionInfo` for
each version of this schema. Use
[`as.list()`](https://rdrr.io/r/base/list.html) to materialize all
results into a list, or `nextElem()` to retrieve one version at a time.
Each `JSONSchemaVersionInfo` has these fields, read with `$`:

- `organization_id`: The ID of the organization.

- `organization_name`: The name of the organization.

- `schema_id`: The ID of the schema.

- `id`: The URI of this schema version.

- `schema_name`: The name of the schema.

- `version_id`: The ID of this schema version.

- `semantic_version`: The semantic version, e.g. `"0.0.1"`.

- `json_sha256_hex`: The SHA-256 hash of the schema body.

- `created_on`: When this version was created.

- `created_by`: The ID of the user that created this version.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get all versions of the JSONSchema
    library(synapser)
    synLogin()

    schema = JSONSchema(organization_name = "dpetest", name = "test.schematic.Biospecimen")
    version_generator = schema |> synGetVersions()
    for (item in as.list(version_generator)) {
        print(item$semantic_version)
    }
} # }
```
