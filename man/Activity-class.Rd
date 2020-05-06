%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Activity-class}
\alias{Activity-class}
\docType{class}
\title{
Activity
}
\format{An R6 class object.}
\description{
Represents the provenance of a Synapse Entity.
}
\section{Methods}{
\itemize{
\item \code{Activity(name=NULL, description=NULL, used=NULL, executed=NULL, data=list())}: Constructor for \code{\link{Activity}}
\item \code{executed(target=NULL, targetVersion=NULL, url=NULL, name=NULL)}: Add a code resource that was executed during the activity.
See synapseclient.activity.Activity.used
\item \code{used(target=NULL, targetVersion=NULL, wasExecuted=NULL, url=NULL, name=NULL)}: Add a resource used by the activity.
}
}
\details{
The \code{\link{used}} method tries to be as permissive as possible. It accepts a string which might be a synapse ID or a URL,
a synapse entity, a UsedEntity or UsedURL dictionary or a list containing any combination of these.

In addition, named parameters can be used to specify the fields of either a UsedEntity or a UsedURL.
If target and optionally targetVersion are specified, create a UsedEntity.
If url and optionally name are specified, create a UsedURL.

It is an error to specify both target/targetVersion parameters and url/name parameters in the same call.
To add multiple UsedEntities and UsedURLs, make a separate call for each or pass in a list.

In case of conflicting settings for wasExecuted both inside an object and with a parameter, the parameter wins.
For example, this UsedURL will have wasExecuted set to False:

activity.used({'url':'http://google.com', 'name':'Goog', 'wasExecuted':True}, wasExecuted=False)

}

%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{

Entity examples::

    activity.used('syn12345')
    activity.used(entity)
    activity.used(target=entity, targetVersion=2)
    activity.used(codeEntity, wasExecuted=True)
    activity.used({'reference':{'target':'syn12345', 'targetVersion':1}, 'wasExecuted':False})

URL examples::

    activity.used('http://mydomain.com/my/awesome/data.RData')
    activity.used(url='http://mydomain.com/my/awesome/data.RData', name='Awesome Data')
    activity.used(url='https://github.com/joe_hacker/code_repo', name='Gnarly hacks', wasExecuted=True)
    activity.used({'url':'https://github.com/joe_hacker/code_repo', 'name':'Gnarly hacks'}, wasExecuted=True)

List example::

    activity.used(['syn12345', 'syn23456', entity,                           {'reference':{'target':'syn100009', 'targetVersion':2}, 'wasExecuted':True},                           'http://mydomain.com/my/awesome/data.RData'])
}
}

