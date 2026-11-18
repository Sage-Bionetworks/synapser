# Properties and annotations

## Properties and annotations, implementation details

In Synapse, entities have both properties and annotations. Properties
are used by the system, whereas annotations are completely user defined.
In synapser, each entity is an object such as a `File`, `Folder`, or
`Project`:

- **Properties** are the object’s own fields, such as `id`, `name`,
  `description`, and `parent_id`. You read them with `$`, for example
  `file$description`.
- **Annotations** are stored together in a single field, `annotations`,
  which is a named list where each name is an annotation key, for
  example `file$annotations`.

Printing an entity will show its properties, with its annotations listed
under `annotations`.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`file`` ``<-`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``"syn123"``, file_options ``=`` `[`FileOptions`](https://r-docs.synapse.org/latest/reference/FileOptions.md)`(``download_file ``=`` ``FALSE``)``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``file``)`

## Properties and annotations are kept separate

Because annotations live in their own named list, a property and an
annotation can share a name without overwriting each other. Each one is
always read from its own place:

\
`file`` ``<-`` ``file`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    description ``=`` ``"One thing"``,`\
`    annotations ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``description ``=`` ``"A different thing"``)`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
\
`file``$``description`` ``# the property`\
`#> [1] "One thing"`\
`file``$``annotations``[[``"description"``]``]`` ``# the annotation`

Even so, it is recommended to avoid defining annotations with names that
collide with properties, because the two are easy to confuse when you
read or query your data.

## Setting properties and annotations

Use
[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
to change both properties and annotations, then
[`synStore()`](https://r-docs.synapse.org/latest/reference/synStore.md)
to save the changes to Synapse. Properties are set by name, and
annotations are set through the `annotations` argument:

\
`file`` ``<-`` ``file`` ``|>`\
`  `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(`\
`    name ``=`` ``"new name"``,`\
`    annotations ``=`` `[`append`](https://rdrr.io/r/base/append.html)`(``file``$``annotations``, `[`list`](https://rdrr.io/r/base/list.html)`(``species ``=`` ``"Homo sapiens"``)``)`\
`  ``)`` ``|>`\
`  `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`

[`synSetProperties()`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
only accepts names that are properties of the entity. Passing any other
name is an error, rather than silently creating a new annotation:

\
`file`` ``|>`` `[`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)`(``species ``=`` ``"Homo sapiens"``)`\
`#> Error: The following are not valid attributes of this entity: species`

To add, update, or remove annotations, change the `annotations` named
list as shown in [Add, Update and Remove
Annotations](https://r-docs.synapse.org/latest/articles/data_upload_download.html#add-update-and-remove-annotations).

See also:

- [`synSetProperties`](https://r-docs.synapse.org/latest/reference/synSetProperties.md)
- [Annotations](https://r-docs.synapse.org/latest/articles/domain_models_of_synapse.html#annotations)
