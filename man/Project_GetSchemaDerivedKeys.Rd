%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSchemaDerivedKeys}
\alias{Project_synGetSchemaDerivedKeys}
\docType{methods}
\title{
Project :  get_schema_derived_keys
}
\description{
Retrieve derived JSON schema keys for the entity.
}
\usage{
synGetSchemaDerivedKeys(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
An object containing the derived keys for the entity.
}
\examples{
\dontrun{
## Using this function
    # Retrieving derived keys from a folder or file. This example demonstrates
    # how to get derived annotation keys from schemas with constant values.
    # Set the PROJECT_NAME variable to your project name.

    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name
    FILE_PATH = "~/Sample.txt"  # replace with your test file path

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    DERIVED_TEST_SCHEMA_NAME = "myTestDerivedSchema"  # replace with your derived schema name
    FOLDER_NAME = "test_script_folder"
    VERSION = "0.0.1"
    SCHEMA_URI = sprintf("\%s-\%s-\%s", ORG_NAME, DERIVED_TEST_SCHEMA_NAME, VERSION)

    # Create the organization and JSON schema used in this example.
    my_test_org = SchemaOrganization(name = ORG_NAME) |> synStore()

    schema_definition = list(
        "$id" = "mySchema",
        type = "object",
        properties = list(
            foo = list(type = "string"),
            baz = list(type = "string", const = "example_value"),  # Example constant for derived annotation
            bar = list(type = "integer")
        ),
        required = list("foo")
    )
    test_schema = JSONSchema(name = DERIVED_TEST_SCHEMA_NAME, organization_name = ORG_NAME) |> synStore(
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
    cat("Bound schema to folder with derived annotations:\n")
    bound_schema

    # Create and bind schema to a file
    example_file = File(
        path = FILE_PATH,  # Replace with your test file path
        parent_id = test_folder$id
    ) |> synStore()

    bound_schema_file = example_file |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to file with derived annotations:\n")
    bound_schema_file

    # Get the derived keys from the bound schema of the folder
    test_folder = test_folder |> synSetProperties(
        annotations = list(foo = "test_value_new", bar = 42L)  # Example annotations
    ) |> synStore()
    cat("Added annotations to folder and stored\n")

    derived_keys = test_folder |> synGetSchemaDerivedKeys()
    cat("Derived keys from folder:\n")
    derived_keys

    # Get the derived keys from the bound schema of the file
    example_file = example_file |> synSetProperties(
        annotations = list(foo = "test_value_new", bar = 43L)  # Example annotations
    ) |> synStore()
    cat("Added annotations to file and stored\n")

    derived_keys_file = example_file |> synGetSchemaDerivedKeys()
    cat("Derived keys from file:\n")
    derived_keys_file
}
}
\keyword{Project}
