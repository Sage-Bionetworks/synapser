\name{Project}
\alias{Project}
\title{
Synapse Project Constructor
}
\description{
Constructor for Project
}
\usage{
Project(name, ...)
}
\arguments{
 \item{name}{
Name of the Project to be created in Synapse
}
\item{...}{
Additional named parameters are interpreted as properties or annotations on the Project
}
}

\value{
The created Project is returned.  NOTE: This is an in-memory representation.  To persist to Synapse use \code{\link{synStore}()}.
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
    in this case, 'Project'
    }
    \item{\code{synapseWebUrl}}{
    Synapse web URL
    }
    \item{\code{generatedBy}}{
    the Activity which generated this Project, if applicable (see \code{\link{Activity}})
    }
    \item{\code{properties}}{
    Synapse properties for a Project. Properties of interest include:
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
\code{\link{Folder}}
\code{\link{synGet}}
\code{\link{synStore}}
}
