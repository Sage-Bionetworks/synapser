%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSnapshot}
\alias{synSnapshot}
\docType{methods}
\title{
EntityView :  snapshot
}
\description{
Creates a snapshot of the \code{View}-like entity.
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
\item{instance}{(EntityView) The EntityView instance to operate on.}
\item{comment}{(Optional[str]) A unique comment to associate with the snapshot.}
\item{label}{(Optional[str]) A unique label to associate with the snapshot. If this is not a unique label an exception will be raised when you store this to Synapse.}
\item{include_activity}{(bool) If True the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{activity} attribute on the Table and calling the \code{store()} method on the Table instance. Adding an activity to a snapshot of a table is meant to capture the provenance of the data at the time of the snapshot. Defaults to True.}
\item{associate_activity_to_new_version}{(bool) If True the activity will be associated with the new version of the table. If False the activity will not be associated with the new version of the table. Defaults to True.}
\item{timeout}{(int) The number of seconds to wait for the job to complete or progress before raising a SynapseTimeoutError. Defaults to 120.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A \code{TableUpdateTransaction} object which includes the version number of the snapshot.
}
\examples{
\dontrun{
## Example 1: Creating a snapshot of a view with an activity
    # Create a snapshot of a view and include the activity. The activity must
    # have been stored in Synapse by using the \code{activity} attribute on the EntityView
    # and calling the \code{store_async()} method on the EntityView instance. Adding an activity
    # to a snapshot of a entityview is meant to capture the provenance of the data at
    # the time of the snapshot.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import EntityView

    syn = Synapse()
    syn.login()

    async def main():
        view = EntityView(id="syn4567")
        snapshot = await view.snapshot_async(label="Q1 2025", comment="Results collected in Lab A", include_activity=True, associate_activity_to_new_version=True)
        print(snapshot)

    asyncio.run(main())

## Example 2: Creating a snapshot of a view without an activity
    # Create a snapshot of a view without including the activity. This is used in
    # cases where we do not have any Provenance to associate with the snapshot and
    # we do not want to persist any activity that may be present on the view to
    # the new version of the view.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import EntityView

    syn = Synapse()
    syn.login()

    async def main():
        view = EntityView(id="syn4567")
        snapshot = await view.snapshot_async(label="Q1 2025", comment="Results collected in Lab A", include_activity=False, associate_activity_to_new_version=False)
        print(snapshot)

    asyncio.run(main())
}
}
\keyword{EntityView}
