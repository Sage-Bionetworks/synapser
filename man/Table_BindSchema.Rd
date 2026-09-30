\name{synBindSchema}
\alias{Table_synBindSchema}
\docType{methods}
\title{
Table :  bind_schema
}
\description{
Bind a JSON schema to the entity.
}
\usage{
synBindSchema(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{json_schema_uri}{(str) The URI of the JSON schema to bind to the entity.}
\item{enable_derived_annotations}{(bool) If TRUE, enable derived annotations. Defaults to FALSE.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
An object containing details about the JSON schema binding.
}
\examples{
\dontrun{
## Using this function
    # Binding JSON schema to a table. This example expects that you
    # have a Synapse project to use. Set the PROJECT_NAME variable to
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
    cat("Result from binding schema to table:\n")
    bound_schema
}
}
\keyword{Table}
