# Package index

## Client

Functions for authenticating with and configuring the Synapse client.

- [`synLogin()`](https://r-docs.synapse.org/latest/reference/synLogin.md)
  : synLogin
- [`synLogout()`](https://r-docs.synapse.org/latest/reference/synLogout.md)
  : synLogout
- [`synSetEndpoints()`](https://r-docs.synapse.org/latest/reference/synSetEndpoints.md)
  : synSetEndpoints

## Entities

Functions for getting, storing, querying, and managing Synapse entities.

- [`synGet()`](https://r-docs.synapse.org/latest/reference/synGet.md) :
  synGet
- [`FileOptions()`](https://r-docs.synapse.org/latest/reference/FileOptions.md)
  : FileOptions
- [`ActivityOptions()`](https://r-docs.synapse.org/latest/reference/ActivityOptions.md)
  : ActivityOptions
- [`TableOptions()`](https://r-docs.synapse.org/latest/reference/TableOptions.md)
  : TableOptions
- [`LinkOptions()`](https://r-docs.synapse.org/latest/reference/LinkOptions.md)
  : LinkOptions
- [`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
  : synStore
- [`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
  : Set properties of an entity
- [`StoreFileOptions()`](https://r-docs.synapse.org/latest/reference/StoreFileOptions.md)
  : StoreFileOptions
- [`StoreContainerOptions()`](https://r-docs.synapse.org/latest/reference/StoreContainerOptions.md)
  : StoreContainerOptions
- [`StoreTableOptions()`](https://r-docs.synapse.org/latest/reference/StoreTableOptions.md)
  : StoreTableOptions
- [`StoreJSONSchemaOptions()`](https://r-docs.synapse.org/latest/reference/StoreJSONSchemaOptions.md)
  : StoreJSONSchemaOptions
- [`StoreGridOptions()`](https://r-docs.synapse.org/latest/reference/StoreGridOptions.md)
  : StoreGridOptions
- [`synDelete()`](https://r-docs.synapse.org/latest/reference/synDelete.md)
  : synDelete
- [`synFindEntityId()`](https://r-docs.synapse.org/latest/reference/synFindEntityId.md)
  : synFindEntityId
- [`synIsSynapseId()`](https://r-docs.synapse.org/latest/reference/synIsSynapseId.md)
  : synIsSynapseId
- [`synOnweb()`](https://r-docs.synapse.org/latest/reference/synOnweb.md)
  : synOnweb
- [`synPrintEntity()`](https://r-docs.synapse.org/latest/reference/synPrintEntity.md)
  : synPrintEntity
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/VirtualTable_Query.md)
  : VirtualTable : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/VirtualTable_QueryPartMask.md)
  : VirtualTable : query_part_mask
- [`synMd5Query()`](https://r-docs.synapse.org/latest/reference/synMd5Query.md)
  : synMd5Query
- [`synSendMessage()`](https://r-docs.synapse.org/latest/reference/synSendMessage.md)
  : synSendMessage

## REST API

Low-level functions for making direct REST calls to the Synapse server.

- [`synRestGet()`](https://r-docs.synapse.org/latest/reference/synRestGet.md)
  : synRestGet
- [`synRestPost()`](https://r-docs.synapse.org/latest/reference/synRestPost.md)
  : synRestPost
- [`synRestPut()`](https://r-docs.synapse.org/latest/reference/synRestPut.md)
  : synRestPut
- [`synRestDelete()`](https://r-docs.synapse.org/latest/reference/synRestDelete.md)
  : synRestDelete

## Agent

Represents a [Synapse Agent
Registration](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/agent/AgentRegistration.html).

- [`Agent()`](https://r-docs.synapse.org/latest/reference/Agent.md) :
  Agent
- [`synGetChatHistory()`](https://r-docs.synapse.org/latest/reference/Agent_GetChatHistory.md)
  : Agent : get_chat_history
- [`synGetSession()`](https://r-docs.synapse.org/latest/reference/Agent_GetSession.md)
  : Agent : get_session
- [`synPrompt()`](https://r-docs.synapse.org/latest/reference/Agent_Prompt.md)
  : Agent : prompt
- [`synRegister()`](https://r-docs.synapse.org/latest/reference/Agent_Register.md)
  : Agent : register
- [`synStartSession()`](https://r-docs.synapse.org/latest/reference/Agent_StartSession.md)
  : Agent : start_session

## AgentSession

Represents a [Synapse Agent
Session](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/agent/AgentSession.html).

- [`AgentSession()`](https://r-docs.synapse.org/latest/reference/AgentSession.md)
  : AgentSession
- [`synPrompt()`](https://r-docs.synapse.org/latest/reference/AgentSession_Prompt.md)
  : AgentSession : prompt
- [`synStart()`](https://r-docs.synapse.org/latest/reference/AgentSession_Start.md)
  : AgentSession : start
- [`synUpdate()`](https://r-docs.synapse.org/latest/reference/AgentSession_Update.md)
  : AgentSession : update

## AgentPrompt

Represents a prompt, response, and metadata within an AgentSession.

- [`AgentPrompt()`](https://r-docs.synapse.org/latest/reference/AgentPrompt.md)
  : AgentPrompt

## Folder

Folder is a hierarchical container for organizing data in Synapse.

- [`Folder()`](https://r-docs.synapse.org/latest/reference/Folder.md) :
  Folder
- [`synBindSchema()`](https://r-docs.synapse.org/latest/reference/Folder_BindSchema.md)
  : Folder : bind_schema
- [`synCopy()`](https://r-docs.synapse.org/latest/reference/Folder_Copy.md)
  : Folder : copy
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/Folder_DeletePermissions.md)
  : Folder : delete_permissions
- [`synDeleteProjectSetting()`](https://r-docs.synapse.org/latest/reference/Folder_DeleteProjectSetting.md)
  : Folder : delete_project_setting
- [`synFlattenFileList()`](https://r-docs.synapse.org/latest/reference/Folder_FlattenFileList.md)
  : Folder : flatten_file_list
- [`synGenerateSyncManifest()`](https://r-docs.synapse.org/latest/reference/Folder_GenerateSyncManifest.md)
  : Folder : generate_sync_manifest
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Folder_GetAcl.md)
  : Folder : get_acl
- [`synGetInvalidValidation()`](https://r-docs.synapse.org/latest/reference/Folder_GetInvalidValidation.md)
  : Folder : get_invalid_validation
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/Folder_GetPermissions.md)
  : Folder : get_permissions
- [`synGetProjectSetting()`](https://r-docs.synapse.org/latest/reference/Folder_GetProjectSetting.md)
  : Folder : get_project_setting
- [`synGetSchema()`](https://r-docs.synapse.org/latest/reference/Folder_GetSchema.md)
  : Folder : get_schema
- [`synGetSchemaDerivedKeys()`](https://r-docs.synapse.org/latest/reference/Folder_GetSchemaDerivedKeys.md)
  : Folder : get_schema_derived_keys
- [`synGetSchemaValidationStatistics()`](https://r-docs.synapse.org/latest/reference/Folder_GetSchemaValidationStatistics.md)
  : Folder : get_schema_validation_statistics
- [`synGetStsStorageToken()`](https://r-docs.synapse.org/latest/reference/Folder_GetStsStorageToken.md)
  : Folder : get_sts_storage_token
- [`synIndexFilesForMigration()`](https://r-docs.synapse.org/latest/reference/Folder_IndexFilesForMigration.md)
  : Folder : index_files_for_migration
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/Folder_ListAcl.md)
  : Folder : list_acl
- [`synMapDirectoryToAllContainedFiles()`](https://r-docs.synapse.org/latest/reference/Folder_MapDirectoryToAllContainedFiles.md)
  : Folder : map_directory_to_all_contained_files
- [`synMigrateIndexedFiles()`](https://r-docs.synapse.org/latest/reference/Folder_MigrateIndexedFiles.md)
  : Folder : migrate_indexed_files
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/Folder_SetPermissions.md)
  : Folder : set_permissions
- [`synSetStorageLocation()`](https://r-docs.synapse.org/latest/reference/Folder_SetStorageLocation.md)
  : Folder : set_storage_location
- [`synSyncFromSynapse()`](https://r-docs.synapse.org/latest/reference/Folder_SyncFromSynapse.md)
  : Folder : sync_from_synapse
- [`synSyncToSynapse()`](https://r-docs.synapse.org/latest/reference/Folder_SyncToSynapse.md)
  : Folder : sync_to_synapse
- [`synUnbindSchema()`](https://r-docs.synapse.org/latest/reference/Folder_UnbindSchema.md)
  : Folder : unbind_schema
- [`synValidateSchema()`](https://r-docs.synapse.org/latest/reference/Folder_ValidateSchema.md)
  : Folder : validate_schema
- [`synWalk()`](https://r-docs.synapse.org/latest/reference/Folder_Walk.md)
  : Folder : walk

## File

A file within Synapse.

- [`File()`](https://r-docs.synapse.org/latest/reference/File.md) : File
- [`synBindSchema()`](https://r-docs.synapse.org/latest/reference/File_BindSchema.md)
  : File : bind_schema
- [`synChangeMetadata()`](https://r-docs.synapse.org/latest/reference/File_ChangeMetadata.md)
  : File : change_metadata
- [`synCopy()`](https://r-docs.synapse.org/latest/reference/File_Copy.md)
  : File : copy
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/File_DeletePermissions.md)
  : File : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/File_GetAcl.md)
  : File : get_acl
- [`synGetFromId()`](https://r-docs.synapse.org/latest/reference/File_GetFromId.md)
  : File : from_id
- [`synGetFromPath()`](https://r-docs.synapse.org/latest/reference/File_GetFromPath.md)
  : File : from_path
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/File_GetPermissions.md)
  : File : get_permissions
- [`synGetSchema()`](https://r-docs.synapse.org/latest/reference/File_GetSchema.md)
  : File : get_schema
- [`synGetSchemaDerivedKeys()`](https://r-docs.synapse.org/latest/reference/File_GetSchemaDerivedKeys.md)
  : File : get_schema_derived_keys
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/File_ListAcl.md)
  : File : list_acl
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/File_SetPermissions.md)
  : File : set_permissions
- [`synUnbindSchema()`](https://r-docs.synapse.org/latest/reference/File_UnbindSchema.md)
  : File : unbind_schema
- [`synValidateSchema()`](https://r-docs.synapse.org/latest/reference/File_ValidateSchema.md)
  : File : validate_schema

## Project

A Project is a top-level container for organizing data in Synapse.

- [`Project()`](https://r-docs.synapse.org/latest/reference/Project.md)
  : Project
- [`synBindSchema()`](https://r-docs.synapse.org/latest/reference/Project_BindSchema.md)
  : Project : bind_schema
- [`synCopy()`](https://r-docs.synapse.org/latest/reference/Project_Copy.md)
  : Project : copy
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/Project_DeletePermissions.md)
  : Project : delete_permissions
- [`synDeleteProjectSetting()`](https://r-docs.synapse.org/latest/reference/Project_DeleteProjectSetting.md)
  : Project : delete_project_setting
- [`synFlattenFileList()`](https://r-docs.synapse.org/latest/reference/Project_FlattenFileList.md)
  : Project : flatten_file_list
- [`synGenerateSyncManifest()`](https://r-docs.synapse.org/latest/reference/Project_GenerateSyncManifest.md)
  : Project : generate_sync_manifest
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Project_GetAcl.md)
  : Project : get_acl
- [`synGetInvalidValidation()`](https://r-docs.synapse.org/latest/reference/Project_GetInvalidValidation.md)
  : Project : get_invalid_validation
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/Project_GetPermissions.md)
  : Project : get_permissions
- [`synGetProjectSetting()`](https://r-docs.synapse.org/latest/reference/Project_GetProjectSetting.md)
  : Project : get_project_setting
- [`synGetSchema()`](https://r-docs.synapse.org/latest/reference/Project_GetSchema.md)
  : Project : get_schema
- [`synGetSchemaDerivedKeys()`](https://r-docs.synapse.org/latest/reference/Project_GetSchemaDerivedKeys.md)
  : Project : get_schema_derived_keys
- [`synGetSchemaValidationStatistics()`](https://r-docs.synapse.org/latest/reference/Project_GetSchemaValidationStatistics.md)
  : Project : get_schema_validation_statistics
- [`synGetStsStorageToken()`](https://r-docs.synapse.org/latest/reference/Project_GetStsStorageToken.md)
  : Project : get_sts_storage_token
- [`synIndexFilesForMigration()`](https://r-docs.synapse.org/latest/reference/Project_IndexFilesForMigration.md)
  : Project : index_files_for_migration
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/Project_ListAcl.md)
  : Project : list_acl
- [`synMapDirectoryToAllContainedFiles()`](https://r-docs.synapse.org/latest/reference/Project_MapDirectoryToAllContainedFiles.md)
  : Project : map_directory_to_all_contained_files
- [`synMigrateIndexedFiles()`](https://r-docs.synapse.org/latest/reference/Project_MigrateIndexedFiles.md)
  : Project : migrate_indexed_files
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/Project_SetPermissions.md)
  : Project : set_permissions
- [`synSetStorageLocation()`](https://r-docs.synapse.org/latest/reference/Project_SetStorageLocation.md)
  : Project : set_storage_location
- [`synSyncFromSynapse()`](https://r-docs.synapse.org/latest/reference/Project_SyncFromSynapse.md)
  : Project : sync_from_synapse
- [`synSyncToSynapse()`](https://r-docs.synapse.org/latest/reference/Project_SyncToSynapse.md)
  : Project : sync_to_synapse
- [`synUnbindSchema()`](https://r-docs.synapse.org/latest/reference/Project_UnbindSchema.md)
  : Project : unbind_schema
- [`synValidateSchema()`](https://r-docs.synapse.org/latest/reference/Project_ValidateSchema.md)
  : Project : validate_schema
- [`synWalk()`](https://r-docs.synapse.org/latest/reference/Project_Walk.md)
  : Project : walk

## Evaluation

An Evaluation is the core object of the Evaluation API, used to support
collaborative data analysis challenges in Synapse.

- [`Evaluation()`](https://r-docs.synapse.org/latest/reference/Evaluation.md)
  : Evaluation
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAcl.md)
  : Evaluation : get_acl
- [`synGetAllEvaluations()`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAllEvaluations.md)
  : Evaluation : get_all_evaluations
- [`synGetAvailableEvaluations()`](https://r-docs.synapse.org/latest/reference/Evaluation_GetAvailableEvaluations.md)
  : Evaluation : get_available_evaluations
- [`synGetEvaluationsByProject()`](https://r-docs.synapse.org/latest/reference/Evaluation_GetEvaluationsByProject.md)
  : Evaluation : get_evaluations_by_project
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/Evaluation_GetPermissions.md)
  : Evaluation : get_permissions
- [`synUpdateAcl()`](https://r-docs.synapse.org/latest/reference/Evaluation_UpdateAcl.md)
  : Evaluation : update_acl

## Submission

A `Submission` object represents a Synapse Submission, which is created
when a user submits an entity to an evaluation queue.

- [`Submission()`](https://r-docs.synapse.org/latest/reference/Submission.md)
  : Submission
- [`synCancel()`](https://r-docs.synapse.org/latest/reference/Submission_Cancel.md)
  : Submission : cancel
- [`synGetEvaluationSubmissions()`](https://r-docs.synapse.org/latest/reference/Submission_GetEvaluationSubmissions.md)
  : Submission : get_evaluation_submissions
- [`synGetSubmissionCount()`](https://r-docs.synapse.org/latest/reference/Submission_GetSubmissionCount.md)
  : Submission : get_submission_count
- [`synGetUserSubmissions()`](https://r-docs.synapse.org/latest/reference/Submission_GetUserSubmissions.md)
  : Submission : get_user_submissions

## SubmissionStatus

A SubmissionStatus is a secondary, mutable object associated with a
Submission.

- [`SubmissionStatus()`](https://r-docs.synapse.org/latest/reference/SubmissionStatus.md)
  : SubmissionStatus
- [`synBatchUpdateSubmissionStatuses()`](https://r-docs.synapse.org/latest/reference/SubmissionStatus_BatchUpdateSubmissionStatuses.md)
  : SubmissionStatus : batch_update_submission_statuses
- [`synGetAllSubmissionStatuses()`](https://r-docs.synapse.org/latest/reference/SubmissionStatus_GetAllSubmissionStatuses.md)
  : SubmissionStatus : get_all_submission_statuses

## SubmissionBundle

A `SubmissionBundle` object represents a bundle containing a Synapse
Submission and its accompanying SubmissionStatus.

- [`SubmissionBundle()`](https://r-docs.synapse.org/latest/reference/SubmissionBundle.md)
  : SubmissionBundle
- [`synGetEvaluationSubmissionBundles()`](https://r-docs.synapse.org/latest/reference/SubmissionBundle_GetEvaluationSubmissionBundles.md)
  : SubmissionBundle : get_evaluation_submission_bundles
- [`synGetUserSubmissionBundles()`](https://r-docs.synapse.org/latest/reference/SubmissionBundle_GetUserSubmissionBundles.md)
  : SubmissionBundle : get_user_submission_bundles

## Table

A Table represents the metadata of a table.

- [`Table()`](https://r-docs.synapse.org/latest/reference/Table.md) :
  Table
- [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/Table_AddColumn.md)
  : Table : add_column
- [`synBindSchema()`](https://r-docs.synapse.org/latest/reference/Table_BindSchema.md)
  : Table : bind_schema
- [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/Table_DeleteColumn.md)
  : Table : delete_column
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/Table_DeletePermissions.md)
  : Table : delete_permissions
- [`synDeleteRows()`](https://r-docs.synapse.org/latest/reference/Table_DeleteRows.md)
  : Table : delete_rows
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Table_GetAcl.md)
  : Table : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/Table_GetPermissions.md)
  : Table : get_permissions
- [`synGetSchema()`](https://r-docs.synapse.org/latest/reference/Table_GetSchema.md)
  : Table : get_schema
- [`synGetSchemaDerivedKeys()`](https://r-docs.synapse.org/latest/reference/Table_GetSchemaDerivedKeys.md)
  : Table : get_schema_derived_keys
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/Table_ListAcl.md)
  : Table : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/Table_Query.md)
  : Table : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/Table_QueryPartMask.md)
  : Table : query_part_mask
- [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/Table_ReorderColumn.md)
  : Table : reorder_column
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/Table_SetPermissions.md)
  : Table : set_permissions
- [`synSnapshot()`](https://r-docs.synapse.org/latest/reference/Table_Snapshot.md)
  : Table : snapshot
- [`synStoreRows()`](https://r-docs.synapse.org/latest/reference/Table_StoreRows.md)
  : Table : store_rows
- [`synUnbindSchema()`](https://r-docs.synapse.org/latest/reference/Table_UnbindSchema.md)
  : Table : unbind_schema
- [`synUpsertRows()`](https://r-docs.synapse.org/latest/reference/Table_UpsertRows.md)
  : Table : upsert_rows
- [`synValidateSchema()`](https://r-docs.synapse.org/latest/reference/Table_ValidateSchema.md)
  : Table : validate_schema

## Column

A column model contains the metadata of a single column of a table or
view.

- [`Column()`](https://r-docs.synapse.org/latest/reference/Column.md) :
  Column
- [`synList()`](https://r-docs.synapse.org/latest/reference/Column_List.md)
  : Column : list
- [`JsonSubColumn()`](https://r-docs.synapse.org/latest/reference/JsonSubColumn.md)
  : JsonSubColumn

## VirtualTable

A virtual table is a type of table that is dynamically built from a
Synapse SQL query.

- [`VirtualTable()`](https://r-docs.synapse.org/latest/reference/VirtualTable.md)
  : VirtualTable
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/VirtualTable_DeletePermissions.md)
  : VirtualTable : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/VirtualTable_GetAcl.md)
  : VirtualTable : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/VirtualTable_GetPermissions.md)
  : VirtualTable : get_permissions
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/VirtualTable_ListAcl.md)
  : VirtualTable : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/VirtualTable_Query.md)
  : VirtualTable : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/VirtualTable_QueryPartMask.md)
  : VirtualTable : query_part_mask
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/VirtualTable_SetPermissions.md)
  : VirtualTable : set_permissions

## Dataset

A `Dataset` object represents the metadata of a Synapse Dataset.

- [`Dataset()`](https://r-docs.synapse.org/latest/reference/Dataset.md)
  : Dataset
- [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/Dataset_AddColumn.md)
  : Dataset : add_column
- [`synAddItem()`](https://r-docs.synapse.org/latest/reference/Dataset_AddItem.md)
  : Dataset : add_item
- [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/Dataset_DeleteColumn.md)
  : Dataset : delete_column
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/Dataset_DeletePermissions.md)
  : Dataset : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Dataset_GetAcl.md)
  : Dataset : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/Dataset_GetPermissions.md)
  : Dataset : get_permissions
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/Dataset_ListAcl.md)
  : Dataset : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/Dataset_Query.md)
  : Dataset : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/Dataset_QueryPartMask.md)
  : Dataset : query_part_mask
- [`synRemoveItem()`](https://r-docs.synapse.org/latest/reference/Dataset_RemoveItem.md)
  : Dataset : remove_item
- [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/Dataset_ReorderColumn.md)
  : Dataset : reorder_column
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/Dataset_SetPermissions.md)
  : Dataset : set_permissions
- [`synSnapshot()`](https://r-docs.synapse.org/latest/reference/Dataset_Snapshot.md)
  : Dataset : snapshot
- [`synUpdateRows()`](https://r-docs.synapse.org/latest/reference/Dataset_UpdateRows.md)
  : Dataset : update_rows

## DatasetCollection

A `DatasetCollection` object represents the metadata of a Synapse
Dataset Collection.

- [`DatasetCollection()`](https://r-docs.synapse.org/latest/reference/DatasetCollection.md)
  : DatasetCollection
- [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_AddColumn.md)
  : DatasetCollection : add_column
- [`synAddItem()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_AddItem.md)
  : DatasetCollection : add_item
- [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_DeleteColumn.md)
  : DatasetCollection : delete_column
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_DeletePermissions.md)
  : DatasetCollection : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_GetAcl.md)
  : DatasetCollection : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_GetPermissions.md)
  : DatasetCollection : get_permissions
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_ListAcl.md)
  : DatasetCollection : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_Query.md)
  : DatasetCollection : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_QueryPartMask.md)
  : DatasetCollection : query_part_mask
- [`synRemoveItem()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_RemoveItem.md)
  : DatasetCollection : remove_item
- [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_ReorderColumn.md)
  : DatasetCollection : reorder_column
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_SetPermissions.md)
  : DatasetCollection : set_permissions
- [`synSnapshot()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_Snapshot.md)
  : DatasetCollection : snapshot
- [`synUpdateRows()`](https://r-docs.synapse.org/latest/reference/DatasetCollection_UpdateRows.md)
  : DatasetCollection : update_rows
- [`EntityRef()`](https://r-docs.synapse.org/latest/reference/EntityRef.md)
  : EntityRef

## EntityView

A view of Entities within a defined scope.

- [`EntityView()`](https://r-docs.synapse.org/latest/reference/EntityView.md)
  : EntityView
- [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/EntityView_AddColumn.md)
  : EntityView : add_column
- [`synBindSchema()`](https://r-docs.synapse.org/latest/reference/EntityView_BindSchema.md)
  : EntityView : bind_schema
- [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/EntityView_DeleteColumn.md)
  : EntityView : delete_column
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/EntityView_DeletePermissions.md)
  : EntityView : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/EntityView_GetAcl.md)
  : EntityView : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/EntityView_GetPermissions.md)
  : EntityView : get_permissions
- [`synGetSchema()`](https://r-docs.synapse.org/latest/reference/EntityView_GetSchema.md)
  : EntityView : get_schema
- [`synGetSchemaDerivedKeys()`](https://r-docs.synapse.org/latest/reference/EntityView_GetSchemaDerivedKeys.md)
  : EntityView : get_schema_derived_keys
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/EntityView_ListAcl.md)
  : EntityView : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/EntityView_Query.md)
  : EntityView : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/EntityView_QueryPartMask.md)
  : EntityView : query_part_mask
- [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/EntityView_ReorderColumn.md)
  : EntityView : reorder_column
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/EntityView_SetPermissions.md)
  : EntityView : set_permissions
- [`synSnapshot()`](https://r-docs.synapse.org/latest/reference/EntityView_Snapshot.md)
  : EntityView : snapshot
- [`synUnbindSchema()`](https://r-docs.synapse.org/latest/reference/EntityView_UnbindSchema.md)
  : EntityView : unbind_schema
- [`synUpdateRows()`](https://r-docs.synapse.org/latest/reference/EntityView_UpdateRows.md)
  : EntityView : update_rows
- [`synValidateSchema()`](https://r-docs.synapse.org/latest/reference/EntityView_ValidateSchema.md)
  : EntityView : validate_schema

## MaterializedView

A materialized view is a type of table that is automatically built from
a Synapse SQL query.

- [`MaterializedView()`](https://r-docs.synapse.org/latest/reference/MaterializedView.md)
  : MaterializedView
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/MaterializedView_DeletePermissions.md)
  : MaterializedView : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/MaterializedView_GetAcl.md)
  : MaterializedView : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/MaterializedView_GetPermissions.md)
  : MaterializedView : get_permissions
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/MaterializedView_ListAcl.md)
  : MaterializedView : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/MaterializedView_Query.md)
  : MaterializedView : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/MaterializedView_QueryPartMask.md)
  : MaterializedView : query_part_mask
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/MaterializedView_SetPermissions.md)
  : MaterializedView : set_permissions

## SubmissionView

A `SubmissionView` object represents the metadata of a Synapse
Submission View.

- [`SubmissionView()`](https://r-docs.synapse.org/latest/reference/SubmissionView.md)
  : Constructor for objects of type SubmissionView
- [`synAddColumn()`](https://r-docs.synapse.org/latest/reference/SubmissionView_AddColumn.md)
  : SubmissionView : add_column
- [`synDeleteColumn()`](https://r-docs.synapse.org/latest/reference/SubmissionView_DeleteColumn.md)
  : SubmissionView : delete_column
- [`synDeletePermissions()`](https://r-docs.synapse.org/latest/reference/SubmissionView_DeletePermissions.md)
  : SubmissionView : delete_permissions
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/SubmissionView_GetAcl.md)
  : SubmissionView : get_acl
- [`synGetPermissions()`](https://r-docs.synapse.org/latest/reference/SubmissionView_GetPermissions.md)
  : SubmissionView : get_permissions
- [`synListAcl()`](https://r-docs.synapse.org/latest/reference/SubmissionView_ListAcl.md)
  : SubmissionView : list_acl
- [`synQuery()`](https://r-docs.synapse.org/latest/reference/SubmissionView_Query.md)
  : SubmissionView : query
- [`synQueryPartMask()`](https://r-docs.synapse.org/latest/reference/SubmissionView_QueryPartMask.md)
  : SubmissionView : query_part_mask
- [`synReorderColumn()`](https://r-docs.synapse.org/latest/reference/SubmissionView_ReorderColumn.md)
  : SubmissionView : reorder_column
- [`synSetPermissions()`](https://r-docs.synapse.org/latest/reference/SubmissionView_SetPermissions.md)
  : SubmissionView : set_permissions
- [`synSnapshot()`](https://r-docs.synapse.org/latest/reference/SubmissionView_Snapshot.md)
  : SubmissionView : snapshot

## Activity

An activity is a Synapse object that helps to keep track of what objects
were used in an analysis step, as well as what objects were generated.

- [`Activity()`](https://r-docs.synapse.org/latest/reference/Activity.md)
  : Activity
- [`synDisassociateActivityFromEntity()`](https://r-docs.synapse.org/latest/reference/Activity_DisassociateActivityFromEntity.md)
  : Activity : disassociate_from_entity
- [`synGetFromParent()`](https://r-docs.synapse.org/latest/reference/Activity_GetFromParent.md)
  : Activity : from_parent
- [`UsedEntity()`](https://r-docs.synapse.org/latest/reference/UsedEntity.md)
  : UsedEntity
- [`UsedURL()`](https://r-docs.synapse.org/latest/reference/UsedURL.md)
  : UsedURL

## Team

Represents a [Synapse
Team](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Team.html).

- [`Team()`](https://r-docs.synapse.org/latest/reference/Team.md) : Team
- [`synCreate()`](https://r-docs.synapse.org/latest/reference/Team_Create.md)
  : Team : create
- [`synDeleteInvitation()`](https://r-docs.synapse.org/latest/reference/Team_DeleteInvitation.md)
  : Team : delete_invitation
- [`synGetFromId()`](https://r-docs.synapse.org/latest/reference/Team_GetFromId.md)
  : Team : from_id
- [`synGetFromName()`](https://r-docs.synapse.org/latest/reference/Team_GetFromName.md)
  : Team : from_name
- [`synGetOpenInvitations()`](https://r-docs.synapse.org/latest/reference/Team_GetOpenInvitations.md)
  : Team : open_invitations
- [`synGetTeamMembers()`](https://r-docs.synapse.org/latest/reference/Team_GetTeamMembers.md)
  : Team : members
- [`synGetUserMembershipStatus()`](https://r-docs.synapse.org/latest/reference/Team_GetUserMembershipStatus.md)
  : Team : get_user_membership_status
- [`synInviteToTeam()`](https://r-docs.synapse.org/latest/reference/Team_InviteToTeam.md)
  : Team : invite

## UserProfile

UserProfile represents a user’s profile in the system.

- [`UserProfile()`](https://r-docs.synapse.org/latest/reference/UserProfile.md)
  : UserProfile
- [`synGetFromId()`](https://r-docs.synapse.org/latest/reference/UserProfile_GetFromId.md)
  : UserProfile : from_id
- [`synGetFromUsername()`](https://r-docs.synapse.org/latest/reference/UserProfile_GetFromUsername.md)
  : UserProfile : from_username
- [`synIsCertified()`](https://r-docs.synapse.org/latest/reference/UserProfile_IsCertified.md)
  : UserProfile : is_certified

## UserPreference

UserPreference represents a user preference in the system.

- [`UserPreference()`](https://r-docs.synapse.org/latest/reference/UserPreference.md)
  : UserPreference

## Link

A Link entity within Synapse that references another entity.

- [`Link()`](https://r-docs.synapse.org/latest/reference/Link.md) : Link

## Organization

Represents an
[Organization](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Organization.html).

- [`Organization()`](https://r-docs.synapse.org/latest/reference/Organization.md)
  : Organization
- [`synGetAcl()`](https://r-docs.synapse.org/latest/reference/Organization_GetAcl.md)
  : Organization : get_acl
- [`synGetJsonSchemas()`](https://r-docs.synapse.org/latest/reference/Organization_GetJsonSchemas.md)
  : Organization : get_json_schemas
- [`synUpdateAcl()`](https://r-docs.synapse.org/latest/reference/Organization_UpdateAcl.md)
  : Organization : update_acl

## JSONSchema

Represents a [JSON
Schema](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/JsonSchemaInfo.html).

- [`JSONSchema()`](https://r-docs.synapse.org/latest/reference/JSONSchema.md)
  : JSONSchema
- [`synFromUri()`](https://r-docs.synapse.org/latest/reference/JSONSchema_FromUri.md)
  : JSONSchema : from_uri
- [`synGetBody()`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetBody.md)
  : JSONSchema : get_body
- [`synGetVersions()`](https://r-docs.synapse.org/latest/reference/JSONSchema_GetVersions.md)
  : JSONSchema : get_versions

## WikiPage

Represents a [Wiki
Page](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/v2/wiki/V2WikiPage.html).

- [`WikiPage()`](https://r-docs.synapse.org/latest/reference/WikiPage.md)
  : WikiPage
- [`synCopy()`](https://r-docs.synapse.org/latest/reference/WikiPage_Copy.md)
  : WikiPage : copy
- [`synGetAttachment()`](https://r-docs.synapse.org/latest/reference/WikiPage_GetAttachment.md)
  : WikiPage : get_attachment
- [`synGetAttachmentHandles()`](https://r-docs.synapse.org/latest/reference/WikiPage_GetAttachmentHandles.md)
  : WikiPage : get_attachment_handles
- [`synGetAttachmentPreview()`](https://r-docs.synapse.org/latest/reference/WikiPage_GetAttachmentPreview.md)
  : WikiPage : get_attachment_preview
- [`synGetMarkdownFile()`](https://r-docs.synapse.org/latest/reference/WikiPage_GetMarkdownFile.md)
  : WikiPage : get_markdown_file
- [`synReformatAttachmentFileName()`](https://r-docs.synapse.org/latest/reference/WikiPage_ReformatAttachmentFileName.md)
  : WikiPage : reformat_attachment_file_name
- [`synRestore()`](https://r-docs.synapse.org/latest/reference/WikiPage_Restore.md)
  : WikiPage : restore
- [`synUnzipGzippedFile()`](https://r-docs.synapse.org/latest/reference/WikiPage_UnzipGzippedFile.md)
  : WikiPage : unzip_gzipped_file

## WikiOrderHint

A WikiOrderHint contains the order hint for the root wiki that
corresponds to the given owner ID and type.

- [`WikiOrderHint()`](https://r-docs.synapse.org/latest/reference/WikiOrderHint.md)
  : WikiOrderHint

## WikiHistorySnapshot

A WikiHistorySnapshot contains basic information about an update to a
WikiPage.

- [`WikiHistorySnapshot()`](https://r-docs.synapse.org/latest/reference/WikiHistorySnapshot.md)
  : WikiHistorySnapshot

## WikiHeader

A WikiHeader contains basic metadata about a WikiPage.

- [`WikiHeader()`](https://r-docs.synapse.org/latest/reference/WikiHeader.md)
  : WikiHeader

## Download List

Functions for working with the Synapse download list (cart).

- [`DownloadListItem()`](https://r-docs.synapse.org/latest/reference/DownloadListItem.md)
  : DownloadListItem
- [`synDownloadListAdd()`](https://r-docs.synapse.org/latest/reference/synDownloadListAdd.md)
  : synDownloadListAdd
- [`synDownloadListRemove()`](https://r-docs.synapse.org/latest/reference/synDownloadListRemove.md)
  : synDownloadListRemove
- [`synDownloadListClear()`](https://r-docs.synapse.org/latest/reference/synDownloadListClear.md)
  : synDownloadListClear
- [`synDownloadListManifest()`](https://r-docs.synapse.org/latest/reference/synDownloadListManifest.md)
  : synDownloadListManifest
- [`synDownloadListFiles()`](https://r-docs.synapse.org/latest/reference/synDownloadListFiles.md)
  : synDownloadListFiles

## Storage Locations

Storage locations describe where files are uploaded to and downloaded
from via Synapse.

- [`StorageLocation()`](https://r-docs.synapse.org/latest/reference/StorageLocation.md)
  : StorageLocation
- [`StorageLocationType()`](https://r-docs.synapse.org/latest/reference/StorageLocationType.md)
  : StorageLocationType
