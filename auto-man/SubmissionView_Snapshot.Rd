%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSnapshot}
\alias{synSnapshot}
\docType{methods}
\title{
SubmissionView :  snapshot
}
\description{
Creates a snapshot of the \code{SubmissionView} entity.
Synapse handles snapshot creation differently for \code{Table}- and \code{View}-like
entities. \code{View} snapshots are created using the asyncronous job API.

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
\item{label}{(Optional[str]) A unique label to associate with the snapshot. If this is not a unique label an exception will be raised when you store this to Synapse.}
\item{include_activity}{(bool) If True the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{activity} attribute on the View and calling the \code{store_async()} method on the View instance. Adding an activity to a snapshot of a table is meant to capture the provenance of the data at the time of the snapshot. Defaults to True.}
\item{associate_activity_to_new_version}{(bool) If True the activity will be associated with the new version of the table. If False the activity will not be associated with the new version of the table. Defaults to True.}
\item{timeout}{(int) The number of seconds to wait for the async job to complete. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A \code{TableUpdateTransaction} object which includes the version number of the snapshot.
}
\examples{
\dontrun{
## Example 1: Creating a snapshot of a view with an activity
    # Create a snapshot of a view and include the activity. The activity must have been stored in
    # Synapse by using the \code{activity} attribute on the SubmissionView and calling the \code{store_async()}
    # method on the SubmissionView instance. Adding an activity to a snapshot of a view is meant
    # to capture the provenance of the data at the time of the snapshot.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import SubmissionView, Activity, UsedURL

    syn = Synapse()
    syn.login()

    async def main():
        view = await SubmissionView(id="syn4567").get_async()
        view.activity = Activity(
            name="Activity for snapshot",
            used=[UsedURL(name="Data Source", url="https://example.org")]
        )
        await view.store_async() # Store the activity

        snapshot = await view.snapshot_async(
            label="Q1 2025",
            comment="Submissions reviewed in Lab A",
            include_activity=True,
            associate_activity_to_new_version=True
        )
        print(snapshot)

    asyncio.run(main())

## Example 2: Creating a snapshot of a view without an activity
    # Create a snapshot of a view without including the activity. This is used in
    # cases where we do not have any Provenance to associate with the snapshot and
    # we do not want to persist any activity that may be present on the view to
    # the new version of the view.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import SubmissionView

    syn = Synapse()
    syn.login()

    async def main():
        view = await SubmissionView(id="syn4567").get_async()
        snapshot = await view.snapshot_async(
            label="Q1 2025",
            comment="Submissions reviewed in Lab A",
            include_activity=False,
            associate_activity_to_new_version=False
        )
        print(snapshot)

    asyncio.run(main())
}
}
\keyword{SubmissionView}
