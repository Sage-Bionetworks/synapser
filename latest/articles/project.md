# Project

## Project

Projects in Synapse are “containers” that group relevant content and
people together. All data must be uploaded into a project. Projects can
be private so only you can see the contents, they can be shared with
your collaborators, or they can be made public so anyone on the web can
view your research.

### Tutorial purpose

In this vignette you will:

1.  Create a new project
2.  Print stored attributes about your project
3.  Get an existing project

### Prerequisites

1.  Make sure that you have completed the
    [Installation](https://r-docs.synapse.org/latest/articles/installation.md)
    setup.
2.  Make sure that you have completed the
    [Authentication](https://r-docs.synapse.org/latest/articles/authentication.md)
    setup.

## 1. Create a new project

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`

\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`\
\
`# Project names must be globally unique`\
`project_name`` ``<-`` `[`paste0`](https://rdrr.io/r/base/paste.html)`(`\
`  ``"My uniquely named project about Alzheimer's Disease "``,`\
`  `[`paste`](https://rdrr.io/r/base/paste.html)`(`[`sample`](https://rdrr.io/r/base/sample.html)`(`[`c`](https://rdrr.io/r/base/c.html)`(``letters``, ``LETTERS``, ``0``:``9``)``, ``8``, replace ``=`` ``TRUE``)``, collapse ``=`` ``""``)`\
`)`\
`project`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(``name ``=`` ``project_name``)`` ``|>`` `[`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)`(``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"Created project:"``, ``project``$``id``, ``"\n"``)`

Now that you have created your project you are able to inspect the
project in the [Synapse web
UI](https://www.synapse.org/Profile:v/projects/created_by_me).

## 2. Print stored attributes about your project

\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"My project ID is:"``, ``project``$``id``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"I created my project on:"``, ``project``$``created_on``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"The ID of the user that created my project is:"``, ``project``$``created_by``, ``"\n"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"My project was last modified on:"``, ``project``$``modified_on``, ``"\n"``)`

You’ll notice the output looks like:

    My project ID is: syn12345678
    I created my project on: 2000-01-01T12:00:00.001Z
    The ID of the user that created my project is: 1234567
    My project was last modified on: 2000-01-01T12:00:00.001Z

Find all of the available attributes about your project in the `Project`
reference documentation.

## 3. Get an existing project

Each Project only needs to be created once. Since you’ve already created
it you can access it again by retrieving it using its name.

\
`my_project_object`` ``<-`` `[`Project`](https://r-docs.synapse.org/latest/reference/Project.md)`(``name ``=`` ``project_name``)`` ``|>`` `[`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)`(``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"I just got my project:"``, ``my_project_object``$``name``, ``", id:"``, ``my_project_object``$``id``, ``"\n"``)`

The result will look like:

    I just got my project: My uniquely named project about Alzheimer's Disease, id: syn12345678

## Clean Up

Delete the project and all its contents when done:

\
[`synDelete`](https://r-docs.synapse.org/latest/reference/synDelete.md)`(``project``)`

## References used in this tutorial

- [`Project`](https://r-docs.synapse.org/latest/reference/Project.md)
- [`synStore`](https://r-docs.synapse.org/latest/reference/synStore.md)
- [`synGet`](https://r-docs.synapse.org/latest/reference/synGet.md)
