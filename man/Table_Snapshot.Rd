%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSnapshot}
\alias{synSnapshot}
\docType{methods}
\title{
Table :  snapshot
}
\description{
Request to create a new snapshot of a table. The provided comment, label, and
activity will be applied to the current version thereby creating a snapshot
and locking the current version. After the snapshot is created a new version
will be started with an 'in-progress' label.
}
\usage{
synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Table) The Table instance to operate on.}
\item{comment}{(str) Comment to add to this snapshot to the table.}
\item{label}{(str) Label to add to this snapshot to the table. The label must be unique, if a label is not provided a unique label will be generated.}
\item{include_activity}{(bool) If TRUE the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{$activity} attribute on the Table and calling the \code{synStore()} method on the Table instance. Adding an activity to a snapshot of a table is meant to capture the provenance of the data at the time of the snapshot.}
\item{associate_activity_to_new_version}{(bool) If TRUE the activity will be associated with the new version of the table. If FALSE the activity will not be associated with the new version of the table.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A named list that matches: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/SnapshotResponse.html>
}
\examples{
\dontrun{
## Example 1: Creating a snapshot of a table
    # Comment and label are optional, but filled in for this example.
    library(synapser)
    synLogin()

    my_table = Table(id = "syn1234")
    my_table |> synSnapshot(
        comment = "This is a new snapshot comment",
        label = "This is a unique label"
    )

## Example 2: Including the activity (Provenance) in the snapshot and not pulling it forward to the new in-progress version of the table.
    # By default this method is set up to include the activity in the snapshot and
    # then pull the activity forward to the new version. If you do not want to
    # include the activity in the snapshot you can set include_activity to
    # FALSE. If you do not want to pull the activity forward to the new version
    # you can set associate_activity_to_new_version to FALSE.

    # See the $activity attribute on the Table class for more information on how
    # to interact with the activity.
    library(synapser)
    synLogin()

    my_table = Table(id = "syn1234")
    my_table |> synSnapshot(
        comment = "This is a new snapshot comment",
        label = "This is a unique label",
        include_activity = TRUE,
        associate_activity_to_new_version = FALSE
    )
}
}
\keyword{Table}
