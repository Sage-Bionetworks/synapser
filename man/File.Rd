\name{File}
\alias{File}
\title{
Synapse File Constructor
}
\description{
Constructor for File
}
\usage{
File(path, parentId, synapseStore=TRUE, ...)
}
\arguments{
    \item{path}{
    Path to the file in local file system, or URL to file on the internet
    }
    \item{parentId}{
    The Synapse ID of the parent Project or Folder in which to store the File (e.g. "syn101")
    }
    \item{synapseStore}{
    If 'synapseStore' is TRUE then the file specified by \code{path} will be uploaded to S3 when the constructed File object is passed to \code{\link{synStore}}(), else only the file location is saved, along with other metadata
    }
    \item{...}{
    Additional named parameters are interpreted as properties or annotations on the File
    }
}
\details{
If the parent Project has an associated data store, 
credentials to access the store should be placed in your '.synapseConfig' file: 
The .synapseConfig file goes in your home directory and is in the ".ini" format.  Create a new section 
in the file for the server to be accessed.  The section title is the protocol and host.  Below, put lines for
 username and password, e.g.:
 
[sftp://remote.host.com]

username=myUserName

password=secret
}

\value{
The created File is returned.  NOTE: This is an in-memory representation.  To persist to Synapse use \code{\link{synStore}()}.
}

\section{Slots}{
  \describe{
    \item{\code{filePath}}{
    local path to the file, if downloaded from Synapse
    }
    \item{\code{synapseStore}}{
    flag to tell \link{synStore} whether to store the file or just the loacation of the file, along with any metadata
    }
    \item{\code{fileHandle}}{
    Synapse fileHandle associated with the stored file
    }
    \item{\code{objects}}{
    R objects stored in this File, if previously added by \link{addObject}
    }
    \item{\code{attachOwn}}{
    internally used information to handle file caching
    }
    \item{\code{annotations}}{
    annotations set on the object
    }
    \item{\code{synapseEntityKind}}{
    in this case, 'File'
    }
    \item{\code{synapseWebUrl}}{
    Synapse web URL
    }
    \item{\code{generatedBy}}{
    the Activity which generated this File, if applicable (see \link{Activity})
    }
    \item{\code{properties}}{
    Synapse properties for a File. Properties of interest include:
        \describe{
            \item{id}{
                unique Synapse ID as set by the system upon synStore (not set by user)
            }
            \item{versionNumber}{
                Version of this File
            }
            \item{name}{
                user supplied name, usually the File name
            }
            \item{description}{
                user supplied description
            }
        }
    }
  }
}


\author{
Bruce Hoff
}

\seealso{
\code{\link{Folder}}
\code{\link{Project}}
\code{\link{synGet}}
\code{\link{synStore}}
}
