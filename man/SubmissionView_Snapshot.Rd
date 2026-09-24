\name{synSnapshot}
\alias{SubmissionView_synSnapshot}
\docType{methods}
\title{
SubmissionView :  snapshot
}
\description{
Creates a snapshot of the \code{SubmissionView} entity.
Synapse handles snapshot creation differently for \code{Table}- and \code{View}-like
entities. \code{View} snapshots are created using the asynchronous job API.

Making a snapshot of a view allows you to create an immutable version of the
view at the time of the snapshot. This is useful to create checkpoints in time
that you may go back and reference, or use in a publication. Snapshots are
immutable and cannot be changed. They may only be deleted.
}
\usage{
synSnapshot(instance, comment=NULL, label=NULL, include_activity=TRUE, associate_activity_to_new_version=TRUE, timeout=120L, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionView) The SubmissionView instance to operate on.}
\item{comment}{(Optional[str]) A unique comment to associate with the snapshot.}
\item{label}{(Optional[str]) A unique label to associate with the snapshot. If this is not a unique label an error will be raised when you store this to Synapse.}
\item{include_activity}{(bool) If TRUE the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{$activity} attribute on the SubmissionView and calling the \code{\link[=synStore]{synStore}()} function on the SubmissionView instance. Adding an activity to a snapshot of a table is meant to capture the provenance of the data at the time of the snapshot. Defaults to TRUE.}
\item{associate_activity_to_new_version}{(bool) If TRUE the activity will be associated with the new version of the table. If FALSE the activity will not be associated with the new version of the table. Defaults to TRUE.}
\item{timeout}{(int) The number of seconds to wait for the async job to complete. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{TableUpdateTransaction} object which includes the version number of the snapshot.
}
\examples{
\dontrun{
## Example 1: Creating a snapshot of a view with an activity
    # Create a snapshot of a view and include the activity. The activity must have
    # been stored in Synapse by using the $activity attribute on the SubmissionView
    # and calling the synStore() function on the SubmissionView instance. Adding an
    # activity to a snapshot of a view is meant to capture the provenance of the
    # data at the time of the snapshot.
    library(synapser)
    synLogin()

    view = SubmissionView(id = "syn4567") |> synGet()
    view$activity = Activity(name = "Activity for snapshot")
    view |> synStore() # Store the activity

    snapshot = view |> synSnapshot(
        label = "Q1 2025",
        comment = "Submissions reviewed in Lab A",
        include_activity = TRUE,
        associate_activity_to_new_version = TRUE
    )
    snapshot

## Example 2: Creating a snapshot of a view without an activity
    # Create a snapshot of a view without including the activity. This is used in
    # cases where we do not have any Provenance to associate with the snapshot and
    # we do not want to persist any activity that may be present on the view to
    # the new version of the view.
    library(synapser)
    synLogin()

    view = SubmissionView(id = "syn4567") |> synGet()
    snapshot = view |> synSnapshot(
        label = "Q1 2025",
        comment = "Submissions reviewed in Lab A",
        include_activity = FALSE,
        associate_activity_to_new_version = FALSE
    )
    snapshot
}
}
\keyword{SubmissionView}
