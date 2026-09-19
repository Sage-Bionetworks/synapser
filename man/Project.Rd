%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Project}
\alias{Project}
\docType{class}
\title{
Project
}
\format{An S3-style class object.}
\description{
A Project is a top-level container for organizing data in Synapse.
}
\usage{
Project(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, alias=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), annotations=list(), create_or_update=TRUE, parent_id=NULL)
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this project. A new ID will be generated for new Projects. Once issued, this ID is guaranteed to never change or be re-issued}
\item{name}{(Optional[str]) The name of this project. Must be 256 characters or less. Names may only contain: letters, numbers, spaces, underscores, hyphens, periods, plus signs, apostrophes, and parentheses}
\item{description}{(Optional[str]) The description of this entity. Must be 1000 characters or less.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this entity was created.}
\item{modified_on}{(Optional[str]) The date this entity was last modified.}
\item{created_by}{(Optional[str]) The ID of the user that created this entity.}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this entity.}
\item{alias}{(Optional[str]) The project alias for use in friendly project urls.}
\item{files}{(list[File]) Any files that are at the root directory of the project.}
\item{folders}{(list[Folder]) Any folders that are at the root directory of the project.}
\item{tables}{(list[Table]) Any tables that are at the root directory of the project.}
\item{entityviews}{(list[EntityView]) Any entity views that are at the root directory of the project.}
\item{submissionviews}{(list[SubmissionView]) Any submission views that are at the root directory of the project.}
\item{datasets}{(list[Dataset]) Any datasets that are at the root directory of the project.}
\item{datasetcollections}{(list[DatasetCollection]) Any dataset collections that are at the root directory of the project.}
\item{materializedviews}{(list[MaterializedView]) Any materialized views that are at the root directory of the project.}
\item{virtualtables}{(list[VirtualTable]) Any virtual tables that are at the root directory of the project.}
\item{annotations}{(Optional[dict[str, Union[list[str], list[bool], list[float], list[int], list[date], list[datetime]]]]) Additional metadata associated with the project. The key is the name of your desired annotations. The value is an object containing a list of values (use empty list to represent no values for key) and the value type associated with all values in the list. To remove all annotations set this to an empty named list \code{list()} or NULL and store the entity.}
\item{create_or_update}{(bool) (Store only) Indicates whether the method should automatically perform an update if the resource conflicts with an existing Synapse object. When TRUE this means that any changes to the resource will be non-destructive.\cr
\cr
This boolean is ignored if you've already stored or retrieved the resource from Synapse for this instance at least once. Any changes to the resource will be destructive in this case. For example if you want to delete the content for a field you will need to call \code{\link[=synGet]{synGet}()} and then modify the field.}
\item{parent_id}{(Optional[str]) The parent ID of the project. In practice projects do not have a parent, but this is required for the inner workings of Synapse.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Creating a project
    # This example shows how to create a project
    library(synapser)
    synLogin()

    my_annotations = list(
        my_single_key_string = "a",
        my_key_string = list("b", "a", "c")
    )
    project = Project(
        name = "My unique project name",
        annotations = my_annotations,
        description = "This is a project with random data."
    )

    project = project |> synStore()

    project

## Example 2: Storing several files to a project
    # This example shows how to store several files to a project
    file_1 = File(
        path = path_to_file_1,
        name = name_of_file_1
    )
    file_2 = File(
        path = path_to_file_2,
        name = name_of_file_2
    )
    project$files = list(file_1, file_2)
    project = project |> synStore()
}
}
\section{Methods}{
\itemize{
\item \code{Project(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, alias=NULL, files=list(), folders=list(), tables=list(), entityviews=list(), submissionviews=list(), datasets=list(), datasetcollections=list(), materializedviews=list(), virtualtables=list(), annotations=list(), create_or_update=TRUE, parent_id=NULL)}: Constructor for \code{\link{Project}}
\item \code{\link[=Project_BindSchema]{synBindSchema}(instance, json_schema_uri, enable_derived_annotations=FALSE, synapse_client=NULL)}: Bind a JSON schema to the entity.
\item \code{\link[=synCopy]{synCopy}(instance, destination_id, copy_annotations=TRUE, copy_wiki=TRUE, exclude_types=NULL, file_update_existing=FALSE, file_copy_activity="traceback", synapse_client=NULL)}: You must have already created the Project you will be copying to. It will have
its own Synapse ID and unique name that you will use as the destination_id.
\cr
\cr
Copy the project to another Synapse project. This will recursively copy all
Tables, Links, Files, and Folders within the project.
\item \code{\link[=synDeletePermissions]{synDeletePermissions}(instance, include_self=TRUE, include_container_content=FALSE, recursive=FALSE, target_entity_types=NULL, dry_run=FALSE, show_acl_details=TRUE, show_files_in_containers=TRUE, synapse_client=NULL)}: Delete the entire \strong{local} Access Control List (ACL) for a given Entity. This is not
scoped to a specific user or group, but rather removes all permissions
associated with the Entity. After this operation, the Entity will inherit
permissions from its benefactor, which is typically its parent entity or
the Project it belongs to.
\cr
\cr
In order to remove permissions for a specific user or group, you
should use the \code{\link[=synSetPermissions]{synSetPermissions}()} function with the \code{access_type} set to
an empty list.
\cr
\cr
By default, Entities such as FileEntity and Folder inherit their permission from
their containing Project. For such Entities the Project is the Entity's 'benefactor'.
This permission inheritance can be overridden by creating an ACL for the Entity.
When this occurs the Entity becomes its own benefactor and all permission are
determined by its own ACL.
\cr
\cr
If the ACL of an Entity is deleted, then its benefactor will automatically be set
to its parent's benefactor.
\cr
\cr
\strong{Special notice for Projects:} The ACL for a Project cannot be deleted, you
must individually update or revoke the permissions for each user or group.
\item \code{\link[=synFlattenFileList]{synFlattenFileList}(instance)}: Recursively loop over all of the already retrieved files and folders and return
a list of all files in the container.
\item \code{\link[=synGetAcl]{synGetAcl}(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)}: Get the \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL}
that a user or group has on an Entity.
\item \code{\link[=synGetInvalidValidation]{synGetInvalidValidation}(instance, synapse_client=NULL)}: Get invalid JSON schema validation results for the child entities of a container entity.
\item \code{\link[=synGetPermissions]{synGetPermissions}(instance, synapse_client=NULL)}: Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions}
that the caller has on an Entity.
\item \code{\link[=synGetSchema]{synGetSchema}(instance, synapse_client=NULL)}: Get the JSON schema bound to the entity.
\item \code{\link[=synGetSchemaDerivedKeys]{synGetSchemaDerivedKeys}(instance, synapse_client=NULL)}: Retrieve derived JSON schema keys for the entity.
\item \code{\link[=synGetSchemaValidationStatistics]{synGetSchemaValidationStatistics}(instance, synapse_client=NULL)}: Get validation statistics for a container entity.
\item \code{\link[=synListAcl]{synListAcl}(instance, recursive=FALSE, include_container_content=FALSE, target_entity_types=NULL, log_tree=FALSE, synapse_client=NULL)}: List the Access Control Lists (ACLs) for this entity and optionally its children.
\cr
\cr
This function returns the local sharing settings for the entity and optionally
its children. It provides a mapping of all ACLs for the given container/entity.
\cr
\cr
\strong{Important Note:} This function returns the LOCAL sharing settings only, not
the effective permissions that each Synapse User ID/Team has on the entities.
More permissive permissions could be granted via a Team that the user has access
to that has permissions on the entity, or through inheritance from parent entities.
\item \code{\link[=synMapDirectoryToAllContainedFiles]{synMapDirectoryToAllContainedFiles}(instance, root_path)}: Recursively loop over all of the already retrieved files and folders. Then
return back a named list where the key is the path to the directory at each
level. The value is a list of all files in that directory AND all files in
the child directories.
\cr
\cr
This is used during the creation of the manifest TSV file during the
syncFromSynapse utility function.
\item \code{\link[=synSetPermissions]{synSetPermissions}(instance, principal_id=NULL, access_type=NULL, modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE, synapse_client=NULL)}: Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.
\item \code{\link[=synSyncFromSynapse]{synSyncFromSynapse}(instance, path=NULL, recursive=TRUE, download_file=TRUE, if_collision="overwrite.local", failure_strategy="LOG_EXCEPTION", include_activity=TRUE, follow_link=FALSE, link_hops=1L, queue=NULL, include_types=NULL, synapse_client=NULL)}: Sync this container and all possible sub-folders from Synapse. By default this
will download the files that are found and it will populate the
\code{files} and \code{folders} attributes with the found files and folders, along with
all other entity types (tables, entityviews, etc.) present in the container.
If you only want to retrieve the full tree of metadata about your
container specify \code{download_file} as FALSE.
\cr
\cr
This works similarly to the legacy \href{https://python-docs.synapse.org/reference/synapse_utils/}{synapseutils.syncFromSynapse} utility function, however, this does not
currently support the writing of data to a manifest TSV file. This will be a
future enhancement.
\cr
\cr
Supports syncing Files, Folders, Tables, EntityViews, SubmissionViews, Datasets,
DatasetCollections, MaterializedViews, and VirtualTables from Synapse. The
metadata for these entity types will be populated in their respective
attributes (\code{files}, \code{folders}, \code{tables}, \code{entityviews}, \code{submissionviews},
\code{datasets}, \code{datasetcollections}, \code{materializedviews}, \code{virtualtables}) if
they are found within the container.
\item \code{\link[=synUnbindSchema]{synUnbindSchema}(instance, synapse_client=NULL)}: Unbind the JSON schema bound to the entity.
\item \code{\link[=synValidateSchema]{synValidateSchema}(instance, synapse_client=NULL)}: Validate the entity against the bound JSON schema.
\item \code{\link[=synWalk]{synWalk}(instance, follow_link=FALSE, include_types=NULL, recursive=TRUE, display_ascii_tree=FALSE, synapse_client=NULL)}: Traverse through the hierarchy of entities stored under this container.
Mimics os.walk() behavior but yields EntityHeader objects, with optional
ASCII tree display that continues printing as the walk progresses.
}
}
