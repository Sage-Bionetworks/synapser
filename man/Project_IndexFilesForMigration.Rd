\name{synIndexFilesForMigration}
\alias{Project_synIndexFilesForMigration}
\docType{methods}
\title{
Project :  index_files_for_migration
}
\description{
Index files in this entity for migration to a new storage location.

This is the first step in migrating files to a new storage location.
After indexing, use \code{\link[=Project_synMigrateIndexedFiles]{synMigrateIndexedFiles}()} to perform the actual migration.
}
\usage{
synIndexFilesForMigration(instance, dest_storage_location_id, db_path=NULL, source_storage_location_ids=NULL, file_version_strategy="new", include_table_files=FALSE, continue_on_error=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{dest_storage_location_id}{(integer) The destination storage location ID.}
\item{db_path}{(Optional[character]) Path to the SQLite database file for tracking migration state. If not provided, a temporary directory will be used. The path can be retrieved from the \code{db_path} field of the returned \code{MigrationResult}.}
\item{source_storage_location_ids}{(Optional[list[integer]]) Optional list of source storage location IDs to filter which files to migrate. If NULL, all files are indexed.}
\item{file_version_strategy}{(character) Strategy for handling file versions. Options: 'new' (default) - create new versions, 'all' - migrate all versions, 'latest' - only migrate latest version, 'skip' - skip if file exists.}
\item{include_table_files}{(logical) Whether to include files attached to tables.}
\item{continue_on_error}{(logical) Whether to continue indexing if an error occurs.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{MigrationResult} object containing indexing statistics and the database
path (accessible via \code{result$db_path}).
}
\examples{
\dontrun{
## Indexing files for migration
    # Index files in a project for migration:
    library(synapser)
    synLogin()

    project = Project(id = "syn123") |> synGet()
    result = project |> synIndexFilesForMigration(
        dest_storage_location_id = 12345L
    )
    print(sprintf("Database path: \%s", result$db_path))
    print(result$counts_by_status)
}
}
\keyword{Project}
