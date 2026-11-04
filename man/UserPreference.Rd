\name{UserPreference}
\alias{UserPreference}
\docType{class}
\title{
UserPreference
}
\format{An S3-style class object.}
\description{
A UserPreference represents a user preference in the system.
}
\usage{
UserPreference(name=NULL, value=NULL)
}
\arguments{
\item{name}{(Optional[str]) The name of the user preference.}
\item{value}{(Optional[bool]) The value of the user preference.}
}
\value{
NULL
}
\examples{
\dontrun{
## Inspecting a user's preferences
    # UserPreference objects are found in the `preferences` field of a UserProfile
    library(synapser)
    synLogin()

    profile = UserProfile |> synGetFromUsername(username = "myUsername")
    for (preference in profile$preferences) {
        print(sprintf("\%s: \%s", preference$name, preference$value))
    }
}
}
\section{Methods}{
\itemize{
\item \code{UserPreference(name=NULL, value=NULL)}: Constructor for \code{\link{UserPreference}}
}
}

