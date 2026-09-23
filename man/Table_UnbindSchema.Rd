\name{synUnbindSchema}
\alias{Table_synUnbindSchema}
\docType{methods}
\title{
Table :  unbind_schema
}
\description{
Unbind the JSON schema bound to the entity.
}
\usage{
synUnbindSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Using this function
    # Unbinding a JSON schema from a folder or file. This example demonstrates
    # how to remove schema bindings from entities. Assumes entities already have
    # schemas bound. Set the PROJECT_NAME and FILE_PATH variables to your
    # project name and file path respectively.
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
    example_file = File(
        path = FILE_PATH,  # Replace with your test file path
        parent_id = test_folder$id
    ) |> synStore()
    cat("Created test file:", FILE_PATH, "\n")

    bound_schema_file = example_file |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to file:\n")
    bound_schema_file

    # Unbind the schema from the folder
    test_folder |> synUnbindSchema()
    cat("Successfully unbound schema from folder\n")

    # Unbind the schema from the file
    example_file |> synUnbindSchema()
    cat("Successfully unbound schema from file\n")
}
}
\keyword{Table}
