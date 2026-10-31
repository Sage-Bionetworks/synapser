%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synIndexFilesForMigration}
\alias{Folder_synIndexFilesForMigration}
\docType{methods}
\title{
Folder :  index_files_for_migration
}
\description{
Index files in this entity for migration to a new storage location.

This is the first step in migrating files to a new storage location.
After indexing, use \code{migrate_indexed_files} to perform the actual migration.
}
\usage{
synIndexFilesForMigration(instance, dest_storage_location_id, db_path=NULL, source_storage_location_ids=NULL, file_version_strategy="new", include_table_files=FALSE, continue_on_error=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{dest_storage_location_id}{(int) The destination storage location ID.}
\item{db_path}{(Optional[str]) Path to the SQLite database file for tracking migration state. If not provided, a temporary directory will be used. The path can be retrieved from the returned MigrationResult.db_path.}
\item{source_storage_location_ids}{(Optional[list[int]]) Optional list of source storage location IDs to filter which files to migrate. If None, all files are indexed.}
\item{file_version_strategy}{(str) Strategy for handling file versions. Options: 'new' (default) - create new versions, 'all' - migrate all versions, 'latest' - only migrate latest version, 'skip' - skip if file exists.}
\item{include_table_files}{(bool) Whether to include files attached to tables.}
\item{continue_on_error}{(bool) Whether to continue indexing if an error occurs.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A MigrationResult object containing indexing statistics and the database
    path (accessible via result.db_path).
}
\examples{
\dontrun{
## Indexing files for migration
    Index files in a project for migration:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Project

        syn = Synapse()
        syn.login()

        async def main():
            project = await Project(id="syn123").get_async()
            result = await project.index_files_for_migration_async(
                dest_storage_location_id=12345,
            )
            print(f"Database path: {result.db_path}")
            print(f"Indexed {result.counts_by_status}")

        asyncio.run(main())
}
}
\keyword{Folder}
