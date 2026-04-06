# synGetEvaluationByContentSource

Returns a generator over evaluations that derive their content from the
given entity

## Usage

``` r
synGetEvaluationByContentSource(entity)
```

## Arguments

- entity:

  The Project whose Evaluations are to be fetched.

## Value

a Generator over the Evaluation objects for the given Project. Use
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
evaluationQueues<-synGetEvaluationByContentSource("syn1234567")
} # }
```
