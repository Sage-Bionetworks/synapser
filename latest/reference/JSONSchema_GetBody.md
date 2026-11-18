# JSONSchema : get_body

Gets the body of this JSONSchema

## Usage

``` r
synGetBody(instance, version=NULL, synapse_client=NULL)
```

## Arguments

- instance:

  (JSONSchema) The JSONSchema instance to operate on.

- version:

  (Optional\[character\]) Defaults to NULL.\
  \- If a version is supplied, that version's body will be returned.\
  \- If no version is supplied the most recent version will be returned.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The JSON Schema body, as a named list

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the body of the JSONSchema
    library(synapser)
    synLogin()

    schema = JSONSchema(organization_name = "dpetest", name = "test.schematic.Biospecimen")

    # Get latest version
    latest = schema |> synGetBody()
    print(latest)

    # Get specific version
    first = schema |> synGetBody(version = "0.0.1")
    print(first)
} # }
```
