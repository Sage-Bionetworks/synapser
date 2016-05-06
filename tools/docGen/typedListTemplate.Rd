\name{TypedList}
##alias##
\docType{methods}
\title{
Functions for typed lists
}
\description{Methods for typed lists.}
\usage{
	append(x, values, after = length(x))
	
	set(x, values)
	
	getList(x)
}
\arguments{
  \item{x}{
  A typed list.
  }
  \item{values}{
  Values to go into the list.  Must be of the list's type.
  }
  \item{after}{
  Insertion position.
  }
}
\details{
append() works as it does for lists, but requires that the values being appended match the type of the typed list.

set() replaces all the values with those passed in, first checking that the type of the values is correct.

getList() returns the underlying list.
}

