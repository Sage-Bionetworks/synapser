\name{synGetSchema}
\alias{Folder_synGetSchema}
\docType{methods}
\title{
Folder :  get_schema
}
\description{
Get the JSON schema bound to the entity.
}
\usage{
synGetSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
An object containing details about the bound JSON schema.
}
\examples{
\dontrun{
## Using this function
    # Retrieving the bound JSON schema from a folder or file. This example demonstrates
    # how to get existing schema bindings from entities that already have schemas bound.
    # Set the PROJECT_NAME and FILE_PATH variables to your project name
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

    # Bind JSON schema to the folder first
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

    # Retrieve the bound schema from the folder
    bound_schema = test_folder |> synGetSchema()
    cat("Retrieved schema from folder:\n")
    bound_schema

    # Retrieve the bound schema from the file
    bound_schema_file = example_file |> synGetSchema()
    cat("Retrieved schema from file:\n")
    bound_schema_file
}
}
\keyword{Folder}
