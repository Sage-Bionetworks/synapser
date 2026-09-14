%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synMapDirectoryToAllContainedFiles}
\alias{synMapDirectoryToAllContainedFiles}
\docType{methods}
\title{
Project :  map_directory_to_all_contained_files
}
\description{
Recursively loop over all of the already retrieved files and folders. Then
return back a dictionary where the key is the path to the directory at each
level. The value is a list of all files in that directory AND all files in
the child directories.

This is used during the creation of the manifest TSV file during the
syncFromSynapse utility function.
}
\usage{
synMapDirectoryToAllContainedFiles(instance, root_path)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{root_path}{(str) The root path where the top level files are stored.}
}
\value{
A dictionary where the key is the path to the directory at each level. The
        value is a list of all files in that directory AND all files in the child
        directories.
}
\examples{
\dontrun{
## Using this function
   Returning back a dict with 2 keys:

        Given:
        root_folder
        ├── sub_folder
        │   ├── file1.txt
        │   └── file2.txt

        Returns:
        {
            "root_folder": [file1, file2],
            "root_folder/sub_folder": [file1, file2]
        }


   Returning back a dict with 3 keys:

        Given:
        root_folder
        ├── sub_folder_1
        │   ├── file1.txt
        ├── sub_folder_2
        │   └── file2.txt

        Returns:
        {
            "root_folder": [file1, file2],
            "root_folder/sub_folder_1": [file1]
            "root_folder/sub_folder_2": [file2]
        }
}
}
\keyword{Project}
