\name{synUnbindSchema}
\alias{EntityView_synUnbindSchema}
\docType{methods}
\title{
EntityView :  unbind_schema
}
\description{
Unbind the JSON schema bound to the entity.
}
\usage{
synUnbindSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(EntityView) The EntityView instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Using this function
    # Unbinding a JSON schema from an EntityView. This example demonstrates
    # how to remove a schema binding from an entity. Assumes the entity
    # already has a schema bound. Set the PROJECT_NAME variable to your
    # project name.

    library(synapser)
    synLogin()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name

    PROJECT_ID = synFindEntityId(name = PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    SCHEMA_NAME = "myTestSchema"  # replace with your schema name
    VIEW_NAME = "test_script_entityview"
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

    # Create a test EntityView of the files in the project
    test_view = EntityView(
        name = VIEW_NAME,
        parent_id = PROJECT_ID,
        scope_ids = list(PROJECT_ID),
        view_type_mask = 1L  # 1 = files
    ) |> synStore()
    cat("Created test EntityView:", VIEW_NAME, "\n")

    # Bind JSON schema to the EntityView first
    bound_schema = test_view |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to EntityView:\n")
    bound_schema

    # Unbind the schema from the EntityView
    test_view |> synUnbindSchema()
    cat("Successfully unbound schema from EntityView\n")
}
}
\keyword{EntityView}
