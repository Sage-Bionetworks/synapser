# Folder : migrate_indexed_files

Migrate files that have been indexed with
[`synIndexFilesForMigration()`](https://r-docs.synapse.org/v3.0.0/reference/Folder_IndexFilesForMigration.md).

This is the second step in migrating files to a new storage location.
Files must first be indexed using
[`synIndexFilesForMigration()`](https://r-docs.synapse.org/v3.0.0/reference/Folder_IndexFilesForMigration.md).

**Interactive confirmation:** When called from an interactive shell and
`force=FALSE` (the default), this function will print the number of
items queued for migration and prompt for confirmation before
proceeding. If standard output is not connected to an interactive
terminal (e.g. a script or CI environment), migration is aborted unless
`force=TRUE` is set.

## Usage

``` r
synMigrateIndexedFiles(instance, db_path, create_table_snapshots=TRUE, continue_on_error=FALSE, force=FALSE, synapse_client=NULL)
```

## Arguments

- instance:

  (Folder) The Folder instance to operate on.

- db_path:

  (character) Path to the SQLite database file created by
  [`synIndexFilesForMigration()`](https://r-docs.synapse.org/v3.0.0/reference/Folder_IndexFilesForMigration.md).
  You can get this from the `db_path` field of the `MigrationResult` it
  returns.

- create_table_snapshots:

  (logical) Whether to create table snapshots before migrating table
  files.

- continue_on_error:

  (logical) Whether to continue migration if an error occurs.

- force:

  (logical) Skip the interactive confirmation prompt and proceed with
  migration automatically. Set to `TRUE` when running non-interactively
  (scripts, CI, automated pipelines). Defaults to FALSE.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A `MigrationResult` object containing migration statistics, or NULL if
migration was aborted (user declined the confirmation prompt, or the
session is non-interactive and `force=FALSE`).

## Examples

``` r
if (FALSE) { # \dontrun{
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
} # }
```
