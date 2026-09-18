%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSchemaDerivedKeys}
\alias{synGetSchemaDerivedKeys}
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
    # Set the \code{PROJECT_NAME} variable to your project name.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import File, Folder

    syn = Synapse()
    syn.login()

    # Define Project and JSON schema info
    PROJECT_NAME = "test_json_schema_project"  # replace with your project name
    FILE_PATH = "~/Sample.txt"  # replace with your test file path

    PROJECT_ID = syn.findEntityId(name=PROJECT_NAME)
    ORG_NAME = "UniqueOrg"  # replace with your organization name
    DERIVED_TEST_SCHEMA_NAME = "myTestDerivedSchema"  # replace with your derived schema name
    FOLDER_NAME = "test_script_folder"
    VERSION = "0.0.1"
    SCHEMA_URI = f"{ORG_NAME}-{DERIVED_TEST_SCHEMA_NAME}-{VERSION}"

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
    test_schema = my_test_org.get_json_schema(DERIVED_TEST_SCHEMA_NAME)

    if not test_schema:
        # Create the schema (if not already created)
        schema_definition = {
            "$id": "mySchema",
            "type": "object",
            "properties": {
                "foo": {"type": "string"},
                "baz": {"type": "string", "const": "example_value"},  # Example constant for derived annotation
                "bar": {"type": "integer"},
            },
            "required": ["foo"]
        }
        test_schema = my_test_org.create_json_schema(schema_definition, DERIVED_TEST_SCHEMA_NAME, VERSION)
        print(f"Created new derived schema: {DERIVED_TEST_SCHEMA_NAME}")

    async def main():
        # Create a test folder
        test_folder = Folder(name=FOLDER_NAME, parent_id=PROJECT_ID)
        await test_folder.store_async()
        print(f"Created test folder: {FOLDER_NAME}")

        # Bind JSON schema to the folder
        bound_schema = await test_folder.bind_schema_async(
            json_schema_uri=SCHEMA_URI,
            enable_derived_annotations=True
        )
        print(f"Bound schema to folder with derived annotations: {bound_schema}")

        # Create and bind schema to a file
        example_file = File(
            path=FILE_PATH,  # Replace with your test file path
            parent_id=test_folder.id,
        )
        await example_file.store_async()

        bound_schema_file = await example_file.bind_schema_async(
            json_schema_uri=SCHEMA_URI,
            enable_derived_annotations=True
        )
        print(f"Bound schema to file with derived annotations: {bound_schema_file}")

        # Get the derived keys from the bound schema of the folder
        test_folder.annotations = {"foo": "test_value_new", "bar": 42}  # Example annotations
        await test_folder.store_async()
        print("Added annotations to folder and stored")

        derived_keys = await test_folder.get_schema_derived_keys_async()
        print(f"Derived keys from folder: {derived_keys}")

        # Get the derived keys from the bound schema of the file
        example_file.annotations = {"foo": "test_value_new", "bar": 43}  # Example annotations
        await example_file.store_async()
        print("Added annotations to file and stored")

        derived_keys_file = await example_file.get_schema_derived_keys_async()
        print(f"Derived keys from file: {derived_keys_file}")

    asyncio.run(main())
}
}
\keyword{Project}
