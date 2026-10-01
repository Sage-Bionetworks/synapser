\name{synMigrateIndexedFiles}
\alias{Folder_synMigrateIndexedFiles}
\docType{methods}
\title{
Folder :  migrate_indexed_files
}
\description{
Migrate files that have been indexed with \code{\link[=Folder_synIndexFilesForMigration]{synIndexFilesForMigration}()}.

This is the second step in migrating files to a new storage location.
Files must first be indexed using \code{\link[=Folder_synIndexFilesForMigration]{synIndexFilesForMigration}()}.

\strong{Interactive confirmation:} When called from an interactive shell and
\code{force=FALSE} (the default), this function will print the number of items
queued for migration and prompt for confirmation before proceeding. If
standard output is not connected to an interactive terminal (e.g. a script
or CI environment), migration is aborted unless \code{force=TRUE} is set.
}
\usage{
synMigrateIndexedFiles(instance, db_path, create_table_snapshots=TRUE, continue_on_error=FALSE, force=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{db_path}{(character) Path to the SQLite database file created by \code{\link[=Folder_synIndexFilesForMigration]{synIndexFilesForMigration}()}. You can get this from the \code{db_path} field of the \code{MigrationResult} it returns.}
\item{create_table_snapshots}{(logical) Whether to create table snapshots before migrating table files.}
\item{continue_on_error}{(logical) Whether to continue migration if an error occurs.}
\item{force}{(logical) Skip the interactive confirmation prompt and proceed with migration automatically. Set to \code{TRUE} when running non-interactively (scripts, CI, automated pipelines). Defaults to FALSE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{MigrationResult} object containing migration statistics, or NULL
if migration was aborted (user declined the confirmation prompt, or
the session is non-interactive and \code{force=FALSE}).
}
\examples{
\dontrun{
## Migrating indexed files
    # Migrate previously indexed files:
    library(synapser)
    synLogin()

    folder = Folder(id = "syn123") |> synGet()

    # Index first
    index_result = folder |> synIndexFilesForMigration(
        dest_storage_location_id = 12345L
    )

    # Then migrate using the db_path from the index result
    result = folder |> synMigrateIndexedFiles(
        db_path = index_result$db_path,
        force = TRUE  # Skip interactive confirmation
    )
    print(result$counts_by_status)
}
}
\keyword{Folder}
