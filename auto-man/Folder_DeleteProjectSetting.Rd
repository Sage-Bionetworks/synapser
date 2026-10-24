%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDeleteProjectSetting}
\alias{Folder_synDeleteProjectSetting}
\docType{methods}
\title{
Folder :  delete_project_setting
}
\description{
Delete a project setting by its setting ID.
}
\usage{
synDeleteProjectSetting(instance, setting_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{setting_id}{(str) The ID of the project setting to delete.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
None
}
\section{Errors}{
ValueError: If the entity does not have an id set.
}
\examples{
\dontrun{
## Using this function
    Delete the upload settings for a folder:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Folder

        syn = Synapse()
        syn.login()

        async def main():
            folder = await Folder(id="syn123").get_async()
            await folder.delete_project_setting_async(setting_id="123")

        asyncio.run(main())
}
}
\keyword{Folder}
