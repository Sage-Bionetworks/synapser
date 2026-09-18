%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSchemaValidationStatistics}
\alias{synGetSchemaValidationStatistics}
\docType{methods}
\title{
Project :  get_schema_validation_statistics
}
\description{
Get validation statistics for a container entity.
}
\usage{
synGetSchemaValidationStatistics(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
The validation statistics.
}
\examples{
\dontrun{
## Using this function
    # Retrieving validation statistics for a folder. This example demonstrates
    # how to get validation statistics for a container entity after creating
    # entities with various validation states. Set the PROJECT_NAME variable to your project name.

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

    # Create files within the folder with invalid annotations to generate statistics
    invalid_file = File(
        path = FILE_PATH,  # assumes you have something here or adjust path
        parent_id = test_folder$id
    )
    invalid_file$annotations = list(foo = 123, bar = "not_an_integer")  # both invalid
    invalid_file = invalid_file |> synStore()
    cat("Created file with invalid annotations\n")
    Sys.sleep(2)  # Allow time for processing

    stats = test_folder |> synGetSchemaValidationStatistics()
    cat("Validation statistics:\n")
    stats
}
}
\keyword{Project}
