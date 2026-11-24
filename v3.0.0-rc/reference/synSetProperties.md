# Set properties of an entity

Set one or more properties of a Synapse entity object, such as its
`name`, `description`, `version_label`, `activity`, or `annotations`,
and return the entity so it can be piped into
[`synStore()`](https://r-docs.synapse.org/v3.0.0-rc/reference/synStore.md).

The changes are only made to the local entity object; call
[`synStore()`](https://r-docs.synapse.org/v3.0.0-rc/reference/synStore.md)
to save them to Synapse.

Each argument must be named, and every name must be an attribute of the
entity's model class (for example a field of
[`File`](https://r-docs.synapse.org/v3.0.0-rc/reference/File.md) or
[`Folder`](https://r-docs.synapse.org/v3.0.0-rc/reference/Folder.md));
otherwise an error is raised listing the names that are not valid. When
duplicate properties are provided, the first one will be used. Calling
`synSetProperties()` with no properties returns the entity unchanged.

Setting `annotations` replaces all of the entity's annotations. To add
to the existing annotations, combine them first, e.g.
`annotations = append(entity$annotations, list(key = "value"))`; to
remove all annotations, set `annotations = list()`.

## Usage

``` r
synSetProperties(entity, ...)
```

## Arguments

- entity:

  A Synapse entity object, for example one created with
  [`File()`](https://r-docs.synapse.org/v3.0.0-rc/reference/File.md),
  [`Folder()`](https://r-docs.synapse.org/v3.0.0-rc/reference/Folder.md)
  or
  [`Project()`](https://r-docs.synapse.org/v3.0.0-rc/reference/Project.md),
  or returned by
  [`synGet()`](https://r-docs.synapse.org/v3.0.0-rc/reference/synGet.md).

- ...:

  Named properties to set, e.g. `name = "new name"` or
  `annotations = list(key = "value")`.

## Value

The entity with the properties set.

## Examples

``` r
if (FALSE) { # \dontrun{
synSetProperties(entity, annotations = list(key = "value"))
synSetProperties(entity, name = "new name", annotations = list(key = "value", key2 = "value2"))
} # }
```
