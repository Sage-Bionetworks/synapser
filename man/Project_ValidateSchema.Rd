%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synValidateSchema}
\alias{Project_synValidateSchema}
\docType{methods}
\title{
Project :  validate_schema
}
\description{
Validate the entity against the bound JSON schema.
}
\usage{
synValidateSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
The validation results.
}
\examples{
\dontrun{
## Using this function
    # Validating a project against the bound JSON schema. This example demonstrates
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

    # Get the test project
    test_project = Project(id = PROJECT_ID)

    # Bind JSON schema to the project
    bound_schema = test_project |> synBindSchema(
        json_schema_uri = SCHEMA_URI,
        enable_derived_annotations = TRUE
    )
    cat("Bound schema to project:\n")
    bound_schema

    # Validate the project entity against the bound schema
    test_project = test_project |> synSetProperties(
        annotations = list(foo = "test_value", bar = 42L)
    ) |> synStore()
    cat("Added annotations to project and stored\n")
    Sys.sleep(2)  # Allow time for processing

    validation_response = test_project |> synValidateSchema()
    cat("Project validation response:\n")
    validation_response
}
}
\keyword{Project}
