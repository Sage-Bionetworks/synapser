# synCreateColumn

This is redundant with synStore(Column(...)) and will be removed.

## Usage

``` r
synCreateColumn(name, columnType, maximumSize=NULL, defaultValue=NULL, enumValues=NULL)
```

## Arguments

- name:

  Column name

- columnType:

  Column type

- maximumSize:

  maximum length of values (only used when columnType is STRING)

- defaultValue:

  default values (otherwise defaults to NULL)

- enumValues:

  permitted values

## Value

An object of type Column.
