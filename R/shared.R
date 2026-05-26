# Utilities for getting Python method signatures and documentation
#
# Author: bhoff
###############################################################################

.addPythonAndFoldersToSysPath <- function(srcDir) {
  reticulate::py_run_string("import sys")
  reticulate::py_run_string(sprintf("sys.path.insert(0, '%s')", file.path(srcDir, "python")))
}

# for synapseclient.table module
.cherryPickTableFunctionFilter <- function(x) {
  if (x$name == "Table" || x$name == "build_table") {
    x
  }
}

.removeAllClassesClassFilter <- function(x) NULL

# for synapseclient.Synapse
.synapseClassFunctionFilter <- function(x) {
  if ((!is.null(x$doc) && regexpr("**Deprecated**", x$doc, fixed = TRUE)[1] > 0) ||
      isTRUE(x$deprecated_todo) ||
      (any(x$name == .methodsToOmit))) {
    return(NULL)
  } else {
    x
  }
}

# for synapseclient module
.removeAllFunctionsFunctionFilter <- function(x) NULL

.classesToSkip <- c(
  "Entity",
  "Synapse",
  "QueryMixin",
  "AppendableRowSetRequest",
  "UploadToTableRequest",
  "TableUpdateTransaction",
  "TableSchemaChangeRequest",
  "PartialRow",
  "PartialRowSet",
  "ColumnChange"
)
.methodsToOmit <- c(
  "postURI",
  "getURI",
  "putURI",
  "deleteURI",
  "getACLURI",
  "putACLURI",
  "keys",
  "has_key",
  "set_annotations",
  "fill_from_dict",
  "to_synapse_request",
  "allow_client_caching",
  "invite_to_team"
)

.modelClassMethodsToOmit <- c(
  "query",
  "query_part_mask",
  "format_for_manifest",
  "from_id",
  "from_parent",
  "from_name",
  "from_username"
)

# Non-async function names from synapseclient.operations; excluded from
# model class methods since they are already wrapped via the operations
# generateRWrappers call.
.operationsFunctionNames <- c(
  "delete",
  "download_list_add",
  "download_list_clear",
  "download_list_files",
  "download_list_manifest",
  "download_list_remove",
  "find_entity_id",
  "get",
  "is_synapse_id",
  "md5_query",
  "onweb",
  "print_entity",
  "store"
)

# expose synchronous functions only
.removeAsyncFunctionFilter <- function(x) {
  if (!endsWith(x$name, "_async")) x else NULL
}
# for synapseclient.models
.synapseModelClassFilter <- function(x) {
  if (any(x$name == .classesToSkip)) return(NULL)
  if (!is.null(x$methods)) {
    culledMethods <- lapply(X = x$methods,
                            function(method) {
                              if (any(method$name == .methodsToOmit) ||
                                  grepl("_async$", method$name) ||
                                  any(method$name == .modelClassMethodsToOmit) ||
                                  any(method$name == .operationsFunctionNames)) {
                                NULL
                              } else {
                                method
                              }
                            }
    )
    # Now remove the nulls
    nullIndices <- sapply(culledMethods, is.null)
    if (any(nullIndices)) {
      x$methods <- culledMethods[-which(nullIndices)]
    }
  }
  x
}


# Helper function to get predefined function name mapping for synapseclient.models
#
# @return A list containing explicit mapping configuration for synapseclient.models functions
.synapseClientModelsMapping <- function() {
  list(
    explicit = list(
      "synDisassociateFromEntityActivity" = "synDisassociateActivityFromEntity",
      "synFromPathFile" = "synGetFileFromPath",
      "synInviteTeam" = "synInviteToTeam",
      "synMembersTeam" = "synGetTeamMembers",
      "synOpenInvitationsTeam" = "synGetTeamOpenInvitations"
    )
  )
}