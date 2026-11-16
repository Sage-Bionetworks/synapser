# Project : bind_schema

Bind a JSON schema to the entity.

## Usage

``` r
synBindSchema(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)
```

## Arguments

- instance:

  (Project) The Project instance to operate on.

- json_schema_uri:

  (str) The URI of the JSON schema to bind to the entity.

- enable_derived_annotations:

  (bool) If TRUE, enable derived annotations. Defaults to FALSE.

- synapse_client:

  (Optional\[Synapse\]) The Synapse client instance. If not provided,
  the last created instance from the Synapse class constructor will be
  used.

## Value

An object containing details about the JSON schema binding.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Binding JSON schema to a project. This example expects that you
    # have a Synapse project to use. Set the PROJECT_NAME variable to
    # your project name.
    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    SCHEMA_NAME = "myTestSchema"  # replace with your schema name
    VERSION = "0.0.1"
    SCHEMA_URI = sprintf("%s-%s-%s", ORG_NAME, SCHEMA_NAME, VERSION)

    # Create the organization and JSON schema used in this example.
    my_test_org = Organization(name = ORG_NAME) |> synStore()

    schema_definition = list(
        "$id" = "mySchema",
        type = "object",
        properties = list(
            foo = list(type = "string"),
            bar = list(type = "integer")
        ),
        required = list("foo")
    )
    test_schema = JSONSchema(name = SCHEMA_NAME, organization_name = ORG_NAME) |> synStore(
        json_schema_options = StoreJSONSchemaOptions(schema_body = schema_definition, version = VERSION)
    )

    # Get the test project
    test_project = Project(id = PROJECT_ID)

    # Bind JSON schema to the project
    bound_schema = test_project |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Result from binding schema to project:\n")
    bound_schema
} # }
```
