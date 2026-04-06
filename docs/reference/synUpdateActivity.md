# synUpdateActivity

Modifies an existing Activity.

## Usage

``` r
synUpdateActivity(activity)
```

## Arguments

- activity:

  The Activity to be updated.

## Value

An updated Activity object

## Examples

``` r
if (FALSE) { # \dontrun{
activity<-Activity()
activity$used("syn123")
activity<-synSetProvenance("syn11678572", activity)
activity$used("syn456")
activity<-synUpdateActivity(activity)
} # }
```
