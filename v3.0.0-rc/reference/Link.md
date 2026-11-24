# Link

A Link entity within Synapse that references another entity.

Represents a [Synapse
Link](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/Link.html).

## Usage

``` r
Link(name=NULL, description=NULL, id=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, parent_id=NULL, target_id=NULL, target_version_number=NULL, links_to_class_name=NULL, activity=NULL, annotations=list(), concrete_type=NULL)
```

## Format

An S3-style class object.

## Arguments

- name:

  (Optional\[str\]) The name of this entity. Must be 256 characters or
  less. Names may only contain: letters, numbers, spaces, underscores,
  hyphens, periods, plus signs, apostrophes, and parentheses

- description:

  (Optional\[str\]) The description of this entity. Must be 1000
  characters or less.

- id:

  (Optional\[str\]) The unique immutable ID for this entity. A new ID
  will be generated for new Entities. Once issued, this ID is guaranteed
  to never change or be re-issued

- etag:

  (Optional\[str\]) Synapse employs an Optimistic Concurrency Control
  (OCC) scheme to handle concurrent updates. Since the E-Tag changes
  every time an entity is updated it is used to detect when a client's
  current representation of an entity is out-of-date.

- created_on:

  (Optional\[str\]) (Read Only) The date this entity was created.

- modified_on:

  (Optional\[str\]) (Read Only) The date this entity was last modified.

- created_by:

  (Optional\[str\]) (Read Only) The ID of the user that created this
  entity.

- modified_by:

  (Optional\[str\]) (Read Only) The ID of the user that last modified
  this entity.

- parent_id:

  (Optional\[str\]) The ID of the Entity that is the parent of this
  Entity.

- target_id:

  (Optional\[str\]) The ID of the entity to which this link refers

- target_version_number:

  (Optional\[int\]) The version number of the entity to which this link
  refers

- links_to_class_name:

  (Optional\[str\]) The synapse Entity's class name that this link
  points to.

- activity:

  (Optional\[Activity\]) The Activity model represents the main record
  of Provenance in Synapse. It is analogous to the Activity defined in
  the W3C Specification on Provenance. Activity cannot be removed during
  a store operation by setting it to NULL. You must use
  [`synDelete`](https://r-docs.synapse.org/v3.0.0-rc/reference/synDelete.md)
  or
  [`synDisassociateActivityFromEntity`](https://r-docs.synapse.org/v3.0.0-rc/reference/Activity_DisassociateActivityFromEntity.md).

- annotations:

  (Optional\[dict\[str, Union\[list\[str\], list\[bool\], list\[float\],
  list\[int\], list\[date\], list\[datetime\]\]\]\]) Additional metadata
  associated with the link. The key is the name of your desired
  annotations. The value is an object containing a list of values (use
  empty list to represent no values for key) and the value type
  associated with all values in the list. To remove all annotations set
  this to an empty named list
  [`list()`](https://rdrr.io/r/base/list.html) or NULL and store the
  entity.

- concrete_type:

  (Optional\[str\]) Indicates which implementation of Entity this object
  represents. The value is the fully qualified class name, e.g.
  org.sagebionetworks.repo.model.FileEntity.

## Value

NULL

## Methods

- `Link(name=NULL, description=NULL, id=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, parent_id=NULL, target_id=NULL, target_version_number=NULL, links_to_class_name=NULL, activity=NULL, annotations=list(), concrete_type=NULL)`:
  Constructor for `Link`

## Examples

``` r
if (FALSE) { # \dontrun{
## Creating a link to another entity
    library(synapser)
    synLogin()

    link = Link(name = "My Link", parent_id = "syn123", target_id = "syn456") |> synStore()
    print(link$id)

    # Link to a specific version of the target
    link = Link(
        name = "My Versioned Link",
        parent_id = "syn123",
        target_id = "syn456",
        target_version_number = 2L
    ) |> synStore()
} # }
```
