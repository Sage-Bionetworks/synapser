%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetInvalidValidation}
\alias{synGetInvalidValidation}
\docType{methods}
\title{
Project :  get_invalid_validation
}
\description{
Get invalid JSON schema validation results for a container entity.
}
\usage{
synGetInvalidValidation(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
An object containing the validation response, all validation messages,
                                 and the validation exception details.
}
\examples{
\dontrun{
## Using this function
    # Retrieving invalid validation results for a folder. This example demonstrates
    # how to get detailed invalid validation results for child entities within a container.
    # Set the \code{PROJECT_NAME} variable to your project name.

    import time
    from synapseclient import Synapse
    from synapseclient.models import File, Folder

    syn = Synapse()
    syn.login()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name
    FILE_PATH = "~/Sample.txt"  # replace with your test file path

    PROJECT_ID = syn.findEntityId(name=PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    SCHEMA_NAME = "myTestSchema"  # replace with your schema name
    FOLDER_NAME = "test_script_folder"
    VERSION = "0.0.1"
    SCHEMA_URI = f"{ORG_NAME}-{SCHEMA_NAME}-{VERSION}"

    # Create organization (if not already created)
    js = syn.service("json_schema")
    all_orgs = js.list_organizations()
    for org in all_orgs:
        if org["name"] == ORG_NAME:
            print(f"Organization {ORG_NAME} already exists: {org}")
            break
    else:
        print(f"Creating organization {ORG_NAME}.")
        created_organization = js.create_organization(ORG_NAME)
        print(f"Created organization: {created_organization}")

    my_test_org = js.JsonSchemaOrganization(ORG_NAME)
    test_schema = my_test_org.get_json_schema(SCHEMA_NAME)

    if not test_schema:
        # Create the schema (if not already created)
        schema_definition = {
            "$id": "mySchema",
            "type": "object",
            "properties": {
                "foo": {"type": "string"},
                "baz": {"type": "string", "const": "example_value"},
                "bar": {"type": "integer"},
            },
            "required": ["foo"]
        }
        test_schema = my_test_org.create_json_schema(schema_definition, SCHEMA_NAME, VERSION)
        print(f"Created new schema: {SCHEMA_NAME}")

    # Create a test folder
    test_folder = Folder(name=FOLDER_NAME, parent_id=PROJECT_ID)
    test_folder.store()
    print(f"Created test folder: {FOLDER_NAME}")

    # Bind JSON schema to the folder
    bound_schema = test_folder.bind_schema(
        json_schema_uri=SCHEMA_URI,
        enable_derived_annotations=True
    )
    print(f"Bound schema to folder: {bound_schema}")

    # Create files within the folder with invalid annotations to generate invalid results
    invalid_file1 = File(
        path=FILE_PATH,  # assumes you have something here or adjust path
        parent_id=test_folder.id
    )
    invalid_file1.annotations = {"foo": 123, "bar": "not_an_integer"}  # both invalid
    invalid_file1.store()
    print("Created file with invalid annotations")
    time.sleep(2)  # Allow time for processing

    # Get invalid validation results
    invalid_results = test_folder.get_invalid_validation(synapse_client=syn)
    print(f"Invalid validation items found:")
    for child in invalid_results:
        print(f"Invalid validation item: {child}")
}
}
\keyword{Project}
