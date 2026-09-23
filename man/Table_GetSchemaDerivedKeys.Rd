\name{synGetSchemaDerivedKeys}
\alias{Table_synGetSchemaDerivedKeys}
\docType{methods}
\title{
Table :  get_schema_derived_keys
}
\description{
Retrieve derived JSON schema keys for the entity.
}
\usage{
synGetSchemaDerivedKeys(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
An object containing the derived keys for the entity.
}
\examples{
\dontrun{
## Using this function
    # Retrieving derived keys from a table. This example demonstrates
    # how to get derived annotation keys from schemas with constant values.
    # Set the PROJECT_NAME variable to your project name.

    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    DERIVED_TEST_SCHEMA_NAME = "myTestDerivedSchema"  # replace with your derived schema name
    TABLE_NAME = "test_script_table"
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

    # Create a test table
    test_table = Table(name = TABLE_NAME, parent_id = PROJECT_ID) |> synStore()
    cat("Created test table:", TABLE_NAME, "\n")

    # Bind JSON schema to the table
    bound_schema = test_table |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to table with derived annotations:\n")
    bound_schema

    # Get the derived keys from the bound schema of the table
    test_table = test_table |> synSetProperties(
        annotations = list(foo = "test_value_new", bar = 42L)  # Example annotations
    ) |> synStore()
    cat("Added annotations to table and stored\n")

    derived_keys = test_table |> synGetSchemaDerivedKeys()
    cat("Derived keys from table:\n")
    derived_keys
}
}
\keyword{Table}
