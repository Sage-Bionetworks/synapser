# StoreJSONSchemaOptions

Options for storing JSONSchema entities.

## Usage

``` r
StoreJSONSchemaOptions(schema_body, version=NULL, dry_run=FALSE)
```

## Format

An S3-style class object.

## Arguments

- schema_body:

  (dict) The body of the JSONSchema to store, provided as a named list.

- version:

  (Optional\[str\]) The version of the JSONSchema body to store.

- dry_run:

  (bool) Whether or not to do a dry-run.

## Value

NULL

## Methods

- `StoreJSONSchemaOptions(schema_body, version=NULL, dry_run=FALSE)`:
  Constructor for `StoreJSONSchemaOptions`

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this class
    library(synapser)
    synLogin()

    schema_definition = list(
        "$id" = "mySchema",
        type = "object",
        properties = list(foo = list(type = "string")),
        required = list("foo")
    )
    schema = JSONSchema(name = "my.schema", organization_name = "myUniqueOrgName") |> synStore(
        json_schema_options = StoreJSONSchemaOptions(schema_body = schema_definition, version = "0.0.1")
    )
} # }
```
