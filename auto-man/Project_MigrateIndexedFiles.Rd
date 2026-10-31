%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synMigrateIndexedFiles}
\alias{Project_synMigrateIndexedFiles}
\docType{methods}
\title{
Project :  migrate_indexed_files
}
\description{
Migrate files that have been indexed with \code{index_files_for_migration}.

This is the second step in migrating files to a new storage location.
Files must first be indexed using \code{index_files_for_migration}.

**Interactive confirmation:** When called from an interactive shell and
`\code{force=False}\code{ (the default), this method will print the number of items
queued for migration and prompt for confirmation before proceeding. If
standard output is not connected to an interactive terminal (e.g. a script
or CI environment), migration is aborted unless }\code{force=True}` is set.
}
\usage{
synMigrateIndexedFiles(instance, db_path, create_table_snapshots=TRUE, continue_on_error=FALSE, force=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{db_path}{(str) Path to the SQLite database file created by \code{index_files_for_migration}. You can get this from the MigrationResult.db_path returned by index_files_for_migration.}
\item{create_table_snapshots}{(bool) Whether to create table snapshots before migrating table files.}
\item{continue_on_error}{(bool) Whether to continue migration if an error occurs.}
\item{force}{(bool) Skip the interactive confirmation prompt and proceed with migration automatically. Set to `\code{True}` when running non-interactively (scripts, CI, automated pipelines). Defaults to False.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A MigrationResult object containing migration statistics, or None
    if migration was aborted (user declined the confirmation prompt, or
    the session is non-interactive and force=False).
}
\examples{
\dontrun{
## Migrating indexed files
    Migrate previously indexed files:

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Project

        syn = Synapse()
        syn.login()

        async def main():
            project = await Project(id="syn123").get_async()

            # Index first
            index_result = await project.index_files_for_migration_async(
                dest_storage_location_id=12345,
            )

            # Then migrate using the db_path from index result
            result = await project.migrate_indexed_files_async(
                db_path=index_result.db_path,
                force=True,  # Skip interactive confirmation
            )
            print(f"Migrated {result.counts_by_status}")

        asyncio.run(main())
}
}
\keyword{Project}
