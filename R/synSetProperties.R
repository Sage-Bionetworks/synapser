#' @title Set properties of an entity
#' @description Set properties of an entity. When duplicate properties are provided, the first one will be used.
#' @param entity The entity to set properties of
#' @param ... The properties to set
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
