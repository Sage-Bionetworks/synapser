\name{Folder}
\alias{Folder}
\title{
Synapse Folder Constructor
}
\description{
Constructor for Folder
}
\usage{
Folder(name, parentId, ...)
}
\arguments{
 \item{name}{
Name of the Folder to be created in Synapse
}
\item{parentId}{
The Synapse ID of the parent Project or Folder in which to create the Folder (e.g. "syn101")
}
\item{...}{
Additional named parameters are interpreted as properties or annotations on the Folder
}
}

\value{
The created Folder is returned.  NOTE: This is an in-memory representation.  To persist to Synapse use \code{\link{synStore}()}.
}

\section{Slots}{
  \describe{
    \item{\code{attachOwn}}{
    internally used information to handle file caching
    }
    \item{\code{annotations}}{
    annotations set on the object
    }
    \item{\code{synapseEntityKind}}{
    in this case, 'Folder'
    }
    \item{\code{synapseWebUrl}}{
    Synapse web URL
    }
    \item{\code{generatedBy}}{
    the Activity which generated this Folder, if applicable (see \code{\link{Activity}})
    }
    \item{\code{properties}}{
    Synapse properties for a Folder.
    Properties of interest include:
      \describe{
        \item{\code{id}}{
        unique Synapse ID as set by the system upon synStore (not set by user)
        }
        \item{\code{name}}{
        user supplied name
        }
        \item{\code{description}}{
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
\code{\link{File}}
\code{\link{Project}}
\code{\link{synGet}}
\code{\link{synStore}}
}
