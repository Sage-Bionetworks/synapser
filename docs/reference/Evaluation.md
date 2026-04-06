# Constructor for objects of type Evaluation

An Evaluation Submission queue, allowing submissions, retrieval and
scoring.

## Usage

``` r
Evaluation(name=NULL, description=NULL, contentSource=NULL, submissionReceiptMessage=NULL, submissionInstructionsMessage=NULL)
```

## Arguments

- name:

  optional named parameter: Name of the evaluation  

- description:

  optional named parameter: A short description of the evaluation  

- contentSource:

  optional named parameter: Synapse Project associated with the
  evaluation  

- submissionReceiptMessage:

  optional named parameter: Message to display to users upon
  submission  

- submissionInstructionsMessage:

  optional named parameter: Message to display to users detailing
  acceptable formatting for submissions.

## Value

An object of type Evaluation

## Examples

``` r
if (FALSE) { # \dontrun{
eval <- Evaluation(
  name = sprintf("My unique evaluation created on %s", format(Sys.time(), "%a %b %d %H%M%OS4 %Y")),
  description = "testing",
  contentSource = project$properties$id,
  submissionReceiptMessage = "Thank you for your submission!",
  submissionInstructionsMessage = "This evaluation only accepts files.")
eval <- synStore(eval)
} # }
```
