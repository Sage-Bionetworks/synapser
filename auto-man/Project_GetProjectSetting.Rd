%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetProjectSetting}
\alias{Project_synGetProjectSetting}
\docType{methods}
\title{
Project :  get_project_setting
}
\description{
Get the project setting for this entity.
}
\usage{
synGetProjectSetting(instance, setting_type="upload", synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{setting_type}{(str) The type of setting to retrieve. Currently only 'upload' is supported.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The ProjectSetting object, or None if no setting exists.
}
\section{Errors}{
ValueError: If the entity does not have an id set.
}
\examples{
\dontrun{
## Using this function
    Get the upload settings for a folder:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Folder

        syn = Synapse()
        syn.login()

        async def main():
            folder = await Folder(id="syn123").get_async()
            setting = await folder.get_project_setting_async(setting_type="upload")
            if setting:
                print(f"Storage locations: {setting.locations}")

        asyncio.run(main())
}
}
\keyword{Project}
