%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synValidateSchema}
\alias{synValidateSchema}
\docType{methods}
\title{
File :  validate_schema
}
\description{
Validate the entity against the bound JSON schema.
}
\usage{
synValidateSchema(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(File) The File instance to operate on.}
\item{synapse_client}{(Optional[Synapse], optional) The Synapse client instance. If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
The validation results.
}
\examples{
\dontrun{
## Using this function
    # Validating a folder or file against the bound JSON schema. This example demonstrates
    # how to validate entities with annotations against their bound schemas. Requires entities
    # to have schemas already bound. Set the \code{PROJECT_NAME} and \code{FILE_PATH} variables to your project name
    # and file path respectively.

    import asyncio
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
                "bar": {"type": "integer"},
            },
            "required": ["foo"]
        }
        test_schema = my_test_org.create_json_schema(schema_definition, SCHEMA_NAME, VERSION)
        print(f"Created new schema: {SCHEMA_NAME}")

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
        print(f"Bound schema to folder: {bound_schema}")

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
        print(f"Bound schema to file: {bound_schema_file}")

        # Validate the folder entity against the bound schema
        test_folder.annotations = {"foo": "test_value", "bar": 42}  # Example annotations
        await test_folder.store_async()
        print("Added annotations to folder and stored")
        time.sleep(2)  # Allow time for processing

        validation_response = await test_folder.validate_schema_async()
        print(f"Folder validation response: {validation_response}")

        # Validate the file entity against the bound schema
        example_file.annotations = {"foo": "test_value", "bar": 43}  # Example annotations
        await example_file.store_async()
        print("Added annotations to file and stored")
        time.sleep(2)  # Allow time for processing

        validation_response_file = await example_file.validate_schema_async()
        print(f"File validation response: {validation_response_file}")

    asyncio.run(main())
}
}
\keyword{File}
