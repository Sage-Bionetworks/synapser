\name{synGetSchema}
\alias{Table_synGetSchema}
\docType{methods}
\title{
Table :  get_schema
}
\description{
Get the JSON schema bound to the entity.
}
\usage{
synGetSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
An object containing details about the bound JSON schema.
}
\examples{
\dontrun{
## Using this function
    # Retrieving the bound JSON schema from a table. This example demonstrates
    # how to get an existing schema binding from an entity that already has a
    # schema bound. Set the PROJECT_NAME variable to your project name.

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

    # Bind JSON schema to the table first
    bound_schema = test_table |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to table:\n")
    bound_schema

    # Retrieve the bound schema from the table
    bound_schema = test_table |> synGetSchema()
    cat("Retrieved schema from table:\n")
    bound_schema
}
}
\keyword{Table}
