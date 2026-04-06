# synSubmit

Submit an Entity for
[evaluation](https://r-docs.synapse.org/reference/Evaluation.md).

## Usage

``` r
synSubmit(evaluation, entity, name=NULL, team=NULL, silent=FALSE, submitterAlias=NULL, teamName=NULL, dockerTag=latest)
```

## Arguments

- evaluation:

  Evaluation queue to submit to  

- entity:

  The Entity containing the Submission  

- name:

  A name for this submission.  
  In the absent of this parameter, the entity name will be used.  

- team:

  (optional) A Team object, ID or name of a Team that is registered for
  the  
  challenge  

- silent:

  Set to True to suppress output.  

- submitterAlias:

  (optional) A nickname, possibly for display in leaderboards in place
  of the submitter's  
  name  

- teamName:

  (deprecated) A synonym for submitterAlias  

- dockerTag:

  (optional) The Docker tag must be specified if the entity is a
  DockerRepository. Defaults to "latest".

## Value

A Submission object

## Examples

``` r
if (FALSE) { # \dontrun{
evaluation = synGetEvaluation('123')
entity = synGet('syn456')
submission = synSubmit(evaluation, entity, name='Our Final Answer', team='Blue Team')
} # }
```
