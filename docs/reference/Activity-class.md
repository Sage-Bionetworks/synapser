# Activity

Represents the provenance of a Synapse Entity.

## Format

An R6 class object.

## Methods

- `Activity(name=NULL, description=NULL, used=NULL, executed=NULL, data=list())`:
  Constructor for
  [`Activity`](https://r-docs.synapse.org/reference/Activity.md)

- `executed(target=NULL, targetVersion=NULL, url=NULL, name=NULL)`: Add
  a code resource that was executed during the activity.

- `used(target=NULL, targetVersion=NULL, wasExecuted=NULL, url=NULL, name=NULL)`:
  Add a resource used by the activity.

## Details

The `used` method tries to be as permissive as possible. It accepts a
string which might be a synapse ID or a URL, a synapse entity, a
UsedEntity or UsedURL dictionary or a list containing any combination of
these.

In addition, named parameters can be used to specify the fields of
either a UsedEntity or a UsedURL. If target and optionally targetVersion
are specified, create a UsedEntity. If url and optionally name are
specified, create a UsedURL.

It is an error to specify both target/targetVersion parameters and
url/name parameters in the same call. To add multiple UsedEntities and
UsedURLs, make a separate call for each or pass in a list.

## Examples

``` r
if (FALSE) { # \dontrun{
# Entity examples:
#
activity$used('syn12345')
activity$used(entity)
activity$used(target=entity, targetVersion=2)
activity$used(codeEntity, wasExecuted=TRUE)
activity$used(list(target='syn12345', targetVersion=2), wasExecuted=FALSE)

# URL examples:
# 
activity$used('http://mydomain.com/my/awesome/data.RData')
activity$used(url='http://mydomain.com/my/awesome/data.RData', name='Awesome Data')
activity$used(url='https://github.com/joe_hacker/code_repo', name='Gnarly hacks', wasExecuted=TRUE)
activity$used(list(url='https://github.com/joe_hacker/code_repo', name='Gnarly hacks'), wasExecuted=TRUE)
                  
# In case of conflicting settings for wasExecuted both inside an object and with a
# parameter, the parameter wins. For example, this UsedURL will have wasExecuted set
# to FALSE:
#
activity$used(list(url='http://google.com', name='Goog', wasExecuted=TRUE), wasExecuted=FALSE)
} # }
```
