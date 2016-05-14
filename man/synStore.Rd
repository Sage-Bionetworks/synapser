\name{synStore}
\alias{synStore}
\docType{methods}
\title{
synStore
}
\description{}
\usage{
	synStore(...)
}
\arguments{
\item{...}{Extra parameters, passed by argument name.}
}
\details{
Creates a new Entity or updates an existing Entity,
uploading any files in the process.

:param obj:                 A Synapse Entity, Evaluation, or Wiki
:param used:                The Entity, Synapse ID, or URL
                            used to create the object
:param executed:            The Entity, Synapse ID, or URL
                            representing code executed to create the object
:param activity:            Activity object specifying the user's provenance
:param activityName:        Activity name to be used in conjunction with *used* and *executed*.
:param activityDescription: Activity description to be used in conjunction with *used* and *executed*.
:param createOrUpdate:      Indicates whether the method should automatically perform an update if the 'obj'
                            conflicts with an existing Synapse object.  Defaults to True.
:param forceVersion:        Indicates whether the method should increment the version of the object even if
                            nothing has changed.  Defaults to True.
:param versionLabel:        Arbitrary string used to label the version.
:param isRestricted:        If set to true, an email will be sent to the Synapse access control team
                            to start the process of adding terms-of-use
                            or review board approval for this entity.
                            You will be contacted with regards to the specific data being restricted
                            and the requirements of access.

:returns: A Synapse Entity, Evaluation, or Wiki

Example::

    from synapseclient import Project

    project = Project('My uniquely named project')
    project = syn.store(project)

Adding files with `provenance <Activity.html>`_::

    from synapseclient import File, Activity

    ## A synapse entity *syn1906480* contains data
    ## entity *syn1917825* contains code
    activity = Activity(
        'Fancy Processing',
        description='No seriously, really fancy processing',
        used=['syn1906480', 'http://data_r_us.com/fancy/data.txt'],
        executed='syn1917825')

    test_entity = File('/path/to/data/file.xyz', description='Fancy new data', parent=project)
    test_entity = syn.store(test_entity, activity=activity)
}

