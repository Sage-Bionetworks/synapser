###############################################################################

.addPythonAndFoldersToSysPath <- function(srcDir) {
  reticulate::py_run_string("import sys")
  reticulate::py_run_string(sprintf("sys.path.insert(0, '%s')", file.path(srcDir, "python")))
}

# for synapseclient.Synapse
.synapseClassFunctionFilter <- function(x) {
  if ((!is.null(x$doc) && regexpr("**Deprecated**", x$doc, fixed = TRUE)[1] > 0) ||
      (any(x$name == .methodsToOmit))) {
    return(NULL)
  } else {
    x
  }
}

# Filter to remove async functions from synapseclient.models
.removeAsyncFunctionFilter <- function(x) {
  if (grepl("_async$", x$name)) {
    return(NULL)
  } else {
    x
  }
}

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

.synapseClientClassFilter <- function(x) {
  if (any(x$name == .classesToSkip)) {
    return(NULL)
  }
  if (!is.null(x$methods)) {
    culledMethods <- lapply(X = x$methods,
                            function(method) {
                              if (any(method$name == .methodsToOmit) || grepl("_async$", method$name)) NULL else method;
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


.synapseModelClassFilter <- function(x) {
  if (any(x$name == .classesToSkip)) {
    return(NULL)
  }
  if (!is.null(x$methods)) {
    culledMethods <- lapply(X = x$methods,
                            function(method) {
                              if (any(method$name == .methodsToOmit) || grepl("_async$", method$name) || any(method$name == .modelClassMethodsToOmit)) {
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

