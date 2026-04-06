# synMove

Move a Synapse entity to a new container.

## Usage

``` r
synMove(entity, new_parent)
```

## Arguments

- entity:

  A Synapse ID, a Synapse Entity object, or a local file that is stored
  in Synapse  

- new_parent:

  The new parent container (Folder or Project) to which the entity
  should be moved.

## Value

The Synapse Entity object that has been moved.

## Examples

``` r
if (FALSE) { # \dontrun{
    entity <- synMove('syn456', 'syn123')
} # }
```
