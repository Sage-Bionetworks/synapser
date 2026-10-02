#' @title Set properties of an entity
#' @description Set one or more properties of a Synapse entity object, such as
#' its \code{name}, \code{description}, \code{version_label}, \code{activity},
#' or \code{annotations}, and return the entity so it can be piped into
#' \code{\link{synStore}()}.
#'
#' The changes are only made to the local entity object; call
#' \code{\link{synStore}()} to save them to Synapse.
#'
#' Each argument must be named, and every name must be an attribute of the
#' entity's model class (for example a field of \code{\link{File}} or
#' \code{\link{Folder}}); otherwise an error is raised listing the names that are
#' not valid. When duplicate properties are provided, the first one will be used.
#' Calling \code{synSetProperties()} with no properties returns the entity
#' unchanged.
#'
#' Setting \code{annotations} replaces all of the entity's annotations. To add
#' to the existing annotations, combine them first, e.g.
#' \code{annotations = append(entity$annotations, list(key = "value"))}; to
#' remove all annotations, set \code{annotations = list()}.
#' @param entity A Synapse entity object, for example one created with
#' \code{\link{File}()}, \code{\link{Folder}()} or \code{\link{Project}()}, or
#' returned by \code{\link{synGet}()}.
#' @param ... Named properties to set, e.g. \code{name = "new name"} or
#' \code{annotations = list(key = "value")}.
#' @return The entity with the properties set.
#' @examples
#' \dontrun{
#' synSetProperties(entity, annotations = list(key = "value"))
#' synSetProperties(entity, name = "new name", annotations = list(key = "value", key2 = "value2"))
#' }
synSetProperties <- function(entity, ...) {
  props <- list(...)
  if (length(props) == 0) {
    return(entity)
  }
  if (is.null(names(props)) || any(names(props) == "")) {
    stop(
      "All arguments to synSetProperties must be named, e.g. annotations = list(...)"
    )
  }
  valid_props <- names(entity$`__dataclass_fields__`)
  invalid <- setdiff(names(props), valid_props)
  if (length(invalid) > 0) {
    stop(sprintf(
      "The following are not valid attributes of this entity: %s",
      paste(invalid, collapse = ", ")
    ))
  }
  for (prop in names(props)) {
    entity[[prop]] <- props[[prop]]
  }
  return(entity)
}
