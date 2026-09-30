\name{synValidateSchema}
\alias{File_synValidateSchema}
\docType{methods}
\title{
File :  validate_schema
}
\description{
Validate the entity against the bound JSON schema.
}
\usage{
synValidateSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(File) The File instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
The validation results.
}
\examples{
\dontrun{
## Using this function
    # Validating a folder or file against the bound JSON schema. This example demonstrates
    # how to validate entities with annotations against their bound schemas. Requires entities
    # to have schemas already bound. Set the PROJECT_NAME and FILE_PATH variables to your project name
    # and file path respectively.

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
    SCHEMA_URI = sprintf("\%s-\%s-\%s", ORG_NAME, SCHEMA_NAME, VERSION)

    # Create the organization and JSON schema used in this example.
    my_test_org = SchemaOrganization(name = ORG_NAME) |> synStore()

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

    # Create and bind schema to a file
    example_file = File(path = FILE_PATH, parent_id = test_folder$id) |> synStore()

    bound_schema_file = example_file |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to file:\n")
    bound_schema_file

    # Validate the folder entity against the bound schema
    test_folder = test_folder |> synSetProperties(
        annotations = list(foo = "test_value", bar = 42)
    ) |> synStore()
    cat("Added annotations to folder and stored\n")
    Sys.sleep(2)  # Allow time for processing

    validation_response = test_folder |> synValidateSchema()
    cat("Folder validation response:\n")
    validation_response

    # Validate the file entity against the bound schema
    example_file = example_file |> synSetProperties(
        annotations = list(foo = "test_value", bar = 43)
    ) |> synStore()
    cat("Added annotations to file and stored\n")
    Sys.sleep(2)  # Allow time for processing

    validation_response_file = example_file |> synValidateSchema()
    cat("File validation response:\n")
    validation_response_file
}
}
\keyword{File}
