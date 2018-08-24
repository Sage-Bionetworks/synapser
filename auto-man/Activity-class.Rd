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
\item \code{executed(target=NULL, targetVersion=NULL, url=NULL, name=NULL)}: Add a code resource that was executed during the activity.\cr
See synapseclient.activity.Activity.used
\item \code{used(target=NULL, targetVersion=NULL, wasExecuted=NULL, url=NULL, name=NULL)}: Add a resource used by the activity.\cr
\cr
This method tries to be as permissive as possible. It accepts a string which might be a synapse ID or a URL,\cr
a synapse entity, a UsedEntity or UsedURL dictionary or a list containing any combination of these.\cr
\cr
In addition, named parameters can be used to specify the fields of either a UsedEntity or a UsedURL.\cr
If target and optionally targetVersion are specified, create a UsedEntity.\cr
If url and optionally name are specified, create a UsedURL.\cr
\cr
It is an error to specify both target/targetVersion parameters and url/name parameters in the same call.\cr
To add multiple UsedEntities and UsedURLs, make a separate call for each or pass in a list.\cr
\cr
In case of conflicting settings for wasExecuted both inside an object and with a parameter, the parameter wins.\cr
For example, this UsedURL will have wasExecuted set to False::\cr
\cr
    activity.used({'url':'http://google.com', 'name':'Goog', 'wasExecuted':True}, wasExecuted=False)\cr
\cr
Entity examples::\cr
\cr
    activity.used('syn12345')\cr
    activity.used(entity)\cr
    activity.used(target=entity, targetVersion=2)\cr
    activity.used(codeEntity, wasExecuted=True)\cr
    activity.used({'reference':{'target':'syn12345', 'targetVersion':1}, 'wasExecuted':False})\cr
\cr
URL examples::\cr
\cr
    activity.used('http://mydomain.com/my/awesome/data.RData')\cr
    activity.used(url='http://mydomain.com/my/awesome/data.RData', name='Awesome Data')\cr
    activity.used(url='https://github.com/joe_hacker/code_repo', name='Gnarly hacks', wasExecuted=True)\cr
    activity.used({'url':'https://github.com/joe_hacker/code_repo', 'name':'Gnarly hacks'}, wasExecuted=True)\cr
\cr
List example::\cr
\cr
    activity.used(['syn12345', 'syn23456', entity,                           {'reference':{'target':'syn100009', 'targetVersion':2}, 'wasExecuted':True},                           'http://mydomain.com/my/awesome/data.RData'])
\item \code{usedEntity(target, targetVersion=NULL, wasExecuted=FALSE)}: **Deprecated**\cr
\cr
See synapseclient.Activity.used.
\item \code{usedURL(url, name=NULL, wasExecuted=FALSE)}: **Deprecated**\cr
\cr
See synapseclient.Activity.used.
}
}

