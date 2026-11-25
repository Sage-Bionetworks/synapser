# synOnweb

Open up a browser window to the entity page or wiki-subpage.

## Usage

``` r
synOnweb(entity, subpage_id=NULL, synapse_client=NULL)
```

## Arguments

- entity:

  (Union\[str, Dataset, DatasetCollection, EntityView, File, Folder,
  Link, MaterializedView, Project, RecordSet, SearchIndex,
  SubmissionView, Table, VirtualTable\]) Either an Entity object
  (Dataset, DatasetCollection, EntityView, File, Folder, Link,
  MaterializedView, Project, RecordSet, SearchIndex, SubmissionView,
  Table, VirtualTable) or a Synapse ID string.

- subpage_id:

  (Optional\[str\]) (Optional) ID of one of the wiki's sub-pages.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

The URL that was opened in the browser.

## Examples

``` r
if (FALSE) { # \dontrun{
## Example 1: Opening an entity in browser
    # Open an entity's page in the default web browser:
    library(synapser)
    synLogin()

    # Open by Synapse ID
    url = synOnweb("syn123456")
    print(sprintf("Opened: %s", url))

## Example 2: Opening with an entity object
    # Open an entity using an entity object:
    library(synapser)
    synLogin()

    file = synGet(synapse_id = "syn123456")
    url = synOnweb(file)
    print(sprintf("Opened file: %s", url))

## Example 3: Opening a wiki subpage
    # Open a specific wiki subpage:
    library(synapser)
    synLogin()

    # Open a specific wiki subpage
    url = synOnweb("syn123456", subpage_id = "12345")
    print(sprintf("Opened wiki subpage: %s", url))
} # }
```
