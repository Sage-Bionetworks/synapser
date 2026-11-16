# Organization : get_json_schemas

Gets the JSON Schemas that are part of this organization

## Usage

``` r
synGetJsonSchemas(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Organization) The Organization instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `GeneratorWrapper` object that yields the `JSONSchema` objects that
belong to this organization. Use
[`as.list()`](https://rdrr.io/r/base/list.html) to materialize all
results into a list, or `nextElem()` to retrieve one `JSONSchema` at a
time.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get the JSONSchemas that are part of this Organization
    library(synapser)
    synLogin()

    org = Organization(name = "dpetest")
    js_generator = org |> synGetJsonSchemas()
    for (item in as.list(js_generator)) {
        print(item)
    }
} # }
```
