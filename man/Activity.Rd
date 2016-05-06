\name{Activity}
\alias{Activity}
\title{
Activity Constructor
}
\description{
Constructor for Activity
}
\usage{
Activity()
}
\arguments{
  \item{properties}{
list(name="an activity", description="my description", used=list(e1, e2, ...), executed=list(e3, e4, ...))
where each of e1, e2, ... can be either  a SynapseEntity, an entity ID ("syn1234"), or a URL.
}
}

\value{
The created Activity is returned.
}

\section{Slots}{
  \describe{
    \item{\code{properties}}{
    Synapse properties for an Activity object.
    Properties of interest include:
      \describe{
        \item{\code{id}}{
        unique Synapse ID as set by the system upon synStore (not set by user)
        }
        \item{\code{name}}{
        user supplied name for the Activity
        }
        \item{\code{description}}{
        user supplied description of the Activity
        }
        \item{\code{used}}{
        Combination of 'used' and 'executed' arguments which makes up the upstream objects used by this Activity
        }
      }
    }
  }
}

\author{
Bruce Hoff
}
