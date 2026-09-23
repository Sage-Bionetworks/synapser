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
    # Retrieving derived keys from a project. This example demonstrates
    # how to get derived annotation keys from schemas with constant values.
    # Set the PROJECT_NAME variable to your project name.

    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    DERIVED_TEST_SCHEMA_NAME = "myTestDerivedSchema"  # replace with your derived schema name
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

    # Get the test project
    test_project = Project(id = PROJECT_ID)

    # Bind JSON schema to the project
    bound_schema = test_project |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to project with derived annotations:\n")
    bound_schema

    # Get the derived keys from the bound schema of the project
    test_project = test_project |> synSetProperties(
        annotations = list(foo = "test_value_new", bar = 42L)  # Example annotations
    ) |> synStore()
    cat("Added annotations to project and stored\n")

    derived_keys = test_project |> synGetSchemaDerivedKeys()
    cat("Derived keys from project:\n")
    derived_keys
}
}
\keyword{Project}
