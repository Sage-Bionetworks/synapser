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
\item{include_activity}{(bool) If True the activity will be included in snapshot if it exists. In order to include the activity, the activity must have already been stored in Synapse by using the \code{activity} attribute on the Table and calling the \code{store()} method on the Table instance. Adding an activity to a snapshot of a table is meant to capture the provenance of the data at the time of the snapshot.}
\item{associate_activity_to_new_version}{(bool) If True the activity will be associated with the new version of the table. If False the activity will not be associated with the new version of the table.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A dictionary that matches: <https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/table/SnapshotResponse.html>
}
\examples{
\dontrun{
## Example 1: Creating a snapshot of a table
    # Comment and label are optional, but filled in for this example.

    import asyncio
    from synapseclient.models import Table
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()


    async def main():
        my_table = Table(id="syn1234")
        await my_table.snapshot_async(
            comment="This is a new snapshot comment",
            label="3This is a unique label"
        )

    asyncio.run(main())

## Example 2: Including the activity (Provenance) in the snapshot and not pulling it forward to the new \code{in-progress} version of the table.
    # By default this method is set up to include the activity in the snapshot and
    # then pull the activity forward to the new version. If you do not want to
    # include the activity in the snapshot you can set \code{include_activity} to
    # False. If you do not want to pull the activity forward to the new version
    # you can set \code{associate_activity_to_new_version} to False.

    # See the [activity][synapseclient.models.Activity] attribute on the Table
    # class for more information on how to interact with the activity.

    import asyncio
    from synapseclient.models import Table
    from synapseclient import Synapse

    syn = Synapse()
    syn.login()


    async def main():
        my_table = Table(id="syn1234")
        await my_table.snapshot_async(
            comment="This is a new snapshot comment",
            label="This is a unique label",
            include_activity=True,
            associate_activity_to_new_version=False
        )

    asyncio.run(main())
}
}
\keyword{Table}
