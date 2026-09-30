\name{synValidateSchema}
\alias{Table_synValidateSchema}
\docType{methods}
\title{
Table :  validate_schema
}
\description{
Validate the entity against the bound JSON schema.
}
\usage{
synValidateSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
The validation results.
}
\examples{
\dontrun{
## Using this function
    # Validating a table against the bound JSON schema. This example demonstrates
    # how to validate an entity with annotations against its bound schema. Requires
    # the entity to have a schema already bound. Set the PROJECT_NAME variable to
    # your project name.
    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    SCHEMA_NAME = "myTestSchema"  # replace with your schema name
    TABLE_NAME = "test_script_table"
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

    # Create a test table
    test_table = Table(name = TABLE_NAME, parent_id = PROJECT_ID) |> synStore()
    cat("Created test table:", TABLE_NAME, "\n")

    # Bind JSON schema to the table
    bound_schema = test_table |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to table:\n")
    bound_schema

    # Validate the table entity against the bound schema
    test_table = test_table |> synSetProperties(
        annotations = list(foo = "test_value", bar = 42)
    ) |> synStore()
    cat("Added annotations to table and stored\n")
    Sys.sleep(2)  # Allow time for processing

    validation_response = test_table |> synValidateSchema()
    cat("Table validation response:\n")
    validation_response
}
}
\keyword{Table}
