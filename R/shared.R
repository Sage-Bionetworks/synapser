# Utilities for getting Python method signatures and documentation
#
# Author: bhoff
###############################################################################

.addPythonAndFoldersToSysPath <- function(srcDir) {
  reticulate::py_run_string("import sys")
  reticulate::py_run_string(sprintf(
    "sys.path.insert(0, '%s')",
    file.path(srcDir, "python")
  ))
}

# for synapseclient.table module
.cherryPickTableFunctionFilter <- function(x) {
  if (x$name == "Table" || x$name == "build_table") {
    x
  }
}

.removeAllClassesClassFilter <- function(x) NULL


# for synapseclient.Synapse
.synapseClassMethodsToInclude <- c(
  "login",
  "logout",
  "setEndpoints",
  "sendMessage",
  "rest_get_async",
  "rest_put_async",
  "rest_post_async",
  "rest_delete_async"
)
.synapseClassFunctionFilter <- function(x) {
  if (any(x$name == .synapseClassMethodsToInclude)) x else NULL
}
# for synapseclient module
.removeAllFunctionsFunctionFilter <- function(x) NULL

# Non-async function names from synapseclient.operations; excluded from
# model class methods since they are already wrapped via the operations
# generateRWrappers call.
.operationsFunctionNames <- c(
  "get",
  "store",
  "delete",
  "download_list_files",
  "download_list_manifest",
  "download_list_add",
  "download_list_remove",
  "download_list_clear",
  "find_entity_id",
  "is_synapse_id",
  "md5_query",
  "onweb",
  "print_entity"
)


.modelClassesToInclude <- c(
  "Agent",
  "AgentSession",
  "AgentPrompt",
  "Project",
  "Folder",
  "File",
  #"FileHandle",
  "Evaluation",
  "Submission",
  "SubmissionBundle",
  "SubmissionStatus",
  "Table",
  "Column",
  "VirtualTable",
  "Dataset",
  "DatasetCollection",
  "EntityView",
  "MaterializedView",
  "SubmissionView",
  "Activity",
  "Team",
  "UserProfile",
  #"CurationTask",
  #"RecordSet",
  #"Grid",
  "Link",
  "SchemaOrganization",
  "JSONSchema",
  "WikiOrderHint",
  "WikiHistorySnapshot",
  "WikiHeader",
  "WikiPage"
  #"FormData"
)

.modelClassMethodsToOmit <- c(
  "format_for_manifest",
  "fill_from_dict",
  "to_synapse_request",
  "allow_client_caching"
)
# expose synchronous functions only
.removeAsyncFunctionFilter <- function(x) {
  if (!endsWith(x$name, "_async")) x else NULL
}

# for synapseclient.operations
.operationsFunctionNamesFilter <- function(x) {
  if (any(x$name == .operationsFunctionNames)) x else NULL
}

# for synapseclient.models
.synapseModelClassFilter <- function(x) {
  if (!any(x$name == .modelClassesToInclude)) {
    return(NULL)
  }
  if (!is.null(x$methods)) {
    culledMethods <- lapply(X = x$methods, function(method) {
      if (
        grepl("_async$", method$name) ||
          any(method$name == .modelClassMethodsToOmit) ||
          any(method$name == .operationsFunctionNames)
      ) {
        NULL
      } else {
        method
      }
    })
    x$methods <- Filter(Negate(is.null), culledMethods)
  }
  x
}


# Helper function to get predefined function name mapping for synapseclient.models
#
# @return A list containing explicit mapping configuration for synapseclient.models functions
.functionNameMappingSynapse <- function() {
  list(
    explicit = list(
      "synRestGetAsync" = "synRestGet",
      "synRestPutAsync" = "synRestPut",
      "synRestPostAsync" = "synRestPost",
      "synRestDeleteAsync" = "synRestDelete"
    )
  )
}
.functionNameMappingSynapseclientModels <- function() {
  list(
    explicit = list(
      "synDisassociateFromEntity" = "synDisassociateActivityFromEntity",
      "synFromPath" = "synGetFromPath",
      "synInvite" = "synInviteToTeam",
      "synMembers" = "synGetTeamMembers",
      "synOpenInvitations" = "synGetOpenInvitations"
    )
  )
}
