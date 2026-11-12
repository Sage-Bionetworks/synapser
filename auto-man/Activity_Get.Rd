%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Activity_synGet}
\docType{methods}
\title{
Activity :  get
}
\description{
Get an Activity from Synapse by either activity ID or parent entity ID.
}
\usage{
synGet(cls, activity_id=NULL, parent_id=NULL, parent_version_number=NULL, synapse_client=NULL)
}
\arguments{
\item{cls}{(Activity) The Activity class (or an existing Activity instance) to dispatch this call to.}
\item{activity_id}{(Optional[str]) The ID of the activity to retrieve. If provided, this takes precedence over parent_id.}
\item{parent_id}{(Optional[str]) The ID of the parent entity to get the activity for. Only used if activity_id is not provided (ignored when activity_id is provided).}
\item{parent_version_number}{(Optional[int]) The version number of the parent entity. Only used when parent_id is provided (ignored when activity_id is provided). Gets the most recent version if omitted.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The activity object or None if it does not exist.
}
\section{Errors}{
ValueError: If neither activity_id nor parent_id is provided.
}
\examples{
\dontrun{
## Example 1: Get activity by activity ID
    # Retrieve an activity using its ID.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Activity

    syn = Synapse()
    syn.login()

    async def main():
        activity = await Activity.get_async(activity_id="12345")
        if activity:
            print(f"Activity: {activity.name}")
        else:
            print("Activity not found")

    asyncio.run(main())

## Example 2: Get activity by parent entity ID
    # Retrieve an activity using the parent entity ID.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Activity

    syn = Synapse()
    syn.login()

    async def main():
        activity = await Activity.get_async(parent_id="syn123")
        if activity:
            print(f"Activity: {activity.name}")
        else:
            print("No activity found for entity")

    asyncio.run(main())

## Example 3: Get activity by parent entity ID with version
    # Retrieve an activity for a specific version of a parent entity.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Activity

    syn = Synapse()
    syn.login()

    async def main():
        activity = await Activity.get_async(
            parent_id="syn123",
            parent_version_number=3
        )
        if activity:
            print(f"Activity: {activity.name}")
        else:
            print("No activity found for entity version")

    asyncio.run(main())
}
}
\keyword{Activity}
