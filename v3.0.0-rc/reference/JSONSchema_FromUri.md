# JSONSchema : from_uri

Creates a JSONSchema from a URI. The URI can either be a semantic
version or not:\
\- non-semantic: ORGANIZATION.NAME-SCHEMA.NAME\
\- semantic: ORGANIZATION.NAME-SCHEMA.NAME-MAJOR.MINOR.PATCH

## Usage

``` r
synFromUri(cls, uri)
```

## Arguments

- cls:

  (JSONSchema) The JSONSchema class (or an existing JSONSchema instance)
  to dispatch this call to.

- uri:

  (character) The URI to the JSON Schema in Synapse

## Value

A JSONSchema object

## Errors

An error is raised if the URI isn't in the correct form.

## Examples

``` r
if (FALSE) { # \dontrun{
## Create a JSONSchema from a URI
    library(synapser)

    # Non-semantic URI
    js1 = JSONSchema |> synFromUri(uri = "my.org-my.schema")

    # Semantic URI
    js2 = JSONSchema |> synFromUri(uri = "my.org-my.schema-0.0.1")
} # }
```
