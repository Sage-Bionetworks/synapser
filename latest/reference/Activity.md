# Activity

An activity is a Synapse object that helps to keep track of what objects
were used in an analysis step, as well as what objects were generated.
Thus, all relationships between Synapse objects and an activity are
governed by dependencies. That is, an activity needs to know what it
`used`, and outputs need to know what activity they were `generatedBy`.

## Usage

``` r
Activity(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, used=list(), executed=list())
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[str\]) The unique immutable ID for this activity.

- name:

  (Optional\[str\]) A name for this Activity.

- description:

  (Optional\[str\]) A description for this Activity.

- etag:

  (Optional\[str\]) Synapse employs an Optimistic Concurrency Control
  (OCC) scheme to handle concurrent updates. Since the E-Tag changes
  every time an entity is updated it is used to detect when a client's
  current representation of an entity is out-of-date.

- created_on:

  (Optional\[str\]) The date this object was created.

- modified_on:

  (Optional\[str\]) The date this object was last modified.

- created_by:

  (Optional\[str\]) The user that created this object.

- modified_by:

  (Optional\[str\]) The user that last modified this object.

- used:

  (list\[Union\[UsedEntity, UsedURL\]\]) The entities or URLs used by
  this Activity. Only
  [`UsedEntity`](https://r-docs.synapse.org/latest/reference/UsedEntity.md)
  and
  [`UsedURL`](https://r-docs.synapse.org/latest/reference/UsedURL.md)
  objects are accepted. Other values, such as a plain Synapse ID string
  (for example `"syn123"`), are dropped with no error.

- executed:

  (list\[Union\[UsedEntity, UsedURL\]\]) The entities or URLs executed
  by this Activity. Only
  [`UsedEntity`](https://r-docs.synapse.org/latest/reference/UsedEntity.md)
  and
  [`UsedURL`](https://r-docs.synapse.org/latest/reference/UsedURL.md)
  objects are accepted. Other values, such as a plain Synapse ID string
  (for example `"syn123"`), are dropped with no error.

## Value

NULL

## Methods

- `Activity(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, used=list(), executed=list())`:
  Constructor for `Activity`

- [`synDisassociateActivityFromEntity`](https://r-docs.synapse.org/latest/reference/Activity_DisassociateActivityFromEntity.md)`(cls, parent, synapse_client=NULL)`:
  Disassociate the Activity from the parent entity. This is the first
  step in deleting the Activity. If you have other entities that are
  associated with this Activity you must disassociate them by calling
  this method on them as well.

- [`synGetFromParent`](https://r-docs.synapse.org/latest/reference/Activity_GetFromParent.md)`(cls, parent, parent_version_number=NULL, synapse_client=NULL)`:
  Get the Activity from Synapse based on the parent entity.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Store an Activity on a File
    # Record the provenance of a file: what it used, and what was executed to
    # create it. Storing the Activity with a parent associates it with that entity.
    library(synapser)
    synLogin()

    file = synGet("syn123", file_options = FileOptions(download_file = FALSE))

    activity = Activity(
        name = "Normalization",
        description = "Normalized the raw counts",
        used = list(
            UsedEntity(target_id = "syn456", target_version_number = 1L),
            UsedURL(name = "Reference genome", url = "https://www.ncbi.nlm.nih.gov/grc/human")
        ),
        executed = list(
            UsedURL(name = "Analysis code", url = "https://github.com/my-org/my-analysis")
        )
    )
    activity = activity |> synStore(parent = file)
    print(activity$id)

## Example 2: Get an Activity
    # Retrieve an Activity by its ID, or the Activity associated with an entity.
    # NULL is returned when no Activity exists.
    library(synapser)
    synLogin()

    activity = Activity |> synGet(activity_id = "9876543")
    if (!is.null(activity)) {
        print(activity$name)
    } else {
        print("No activity found")
    }

    # Or the Activity attached to an entity, optionally for a specific version
    activity = Activity |> synGet(parent_id = "syn123", parent_version_number = 1L)
    if (is.null(activity)) {
        print("No activity found for this entity version")
    }

## Example 3: Delete an Activity
    # Disassociate the Activity from its parent entity. The Activity itself is
    # deleted once it has been disassociated from every entity it is attached to;
    # until then you'll receive an error for each remaining entity.
    library(synapser)
    synLogin()

    Activity() |> synDelete(parent = "syn123") # parent is the entity that the Activity is associated with
} # }
```
