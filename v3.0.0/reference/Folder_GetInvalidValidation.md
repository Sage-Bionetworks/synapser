# Folder : get_invalid_validation

Get invalid JSON schema validation results for a container entity.

## Usage

``` r
synGetInvalidValidation(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

- synapse_client:

  (Optional\[Synapse\], optional) The Synapse client instance. If not
  provided, the last created instance from the Synapse class constructor
  will be used.

## Value

A `GeneratorWrapper` object that yields objects containing the
validation response, all validation messages, and the validation
exception details. Use [`as.list()`](https://rdrr.io/r/base/list.html)
to materialize all results into a list, or `nextElem()` to retrieve one
result at a time.

## Note

This only checks the direct children of this entity. It does not check
this entity itself, and it does not check grandchildren (entities nested
two or more levels below this entity).

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Retrieving invalid validation results for a folder. This example demonstrates
    # how to get detailed invalid validation results for child entities within a container.
    # Set the PROJECT_NAME variable to your project name.

    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name
    FILE_PATH = "~/Sample.txt"  # replace with your test file path

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    SCHEMA_NAME = "myTestSchema"  # replace with your schema name
    FOLDER_NAME = "test_script_folder"
    VERSION = "0.0.1"
    SCHEMA_URI = sprintf("%s-%s-%s", ORG_NAME, SCHEMA_NAME, VERSION)

    # Create the organization and JSON schema used in this example.
    my_test_org = Organization(name = ORG_NAME) |> synStore()

    schema_definition = list(
        "$id" = "mySchema",
        type = "object",
        properties = list(
            foo = list(type = "string"),
            baz = list(type = "string", const = "example_value"),
            bar = list(type = "integer")
        ),
        required = list("foo")
    )
    test_schema = JSONSchema(name = SCHEMA_NAME, organization_name = ORG_NAME) |> synStore(
        json_schema_options = StoreJSONSchemaOptions(schema_body = schema_definition, version = VERSION)
    )

    # Create a test folder
    test_folder = Folder(name = FOLDER_NAME, parent_id = PROJECT_ID) |> synStore()
    cat("Created test folder:", FOLDER_NAME, "\n")

    # Bind JSON schema to the folder
    bound_schema = test_folder |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to folder:\n")
    bound_schema

    # Create a file within the folder with invalid annotations to generate invalid results
    invalid_file1 = File(
        path = FILE_PATH,
        parent_id = test_folder$id,
        annotations = list(foo = 123, bar = "not_an_integer")  # both invalid
    ) |> synStore()
    cat("Created file with invalid annotations\n")
    Sys.sleep(2)  # Allow time for processing

    # Get invalid validation results
    invalid_results = test_folder |> synGetInvalidValidation()
    cat("Invalid validation items found:\n")
    for (child in as.list(invalid_results)) {
        cat("Invalid validation item:\n")
        print(child)
    }
} # }
```
