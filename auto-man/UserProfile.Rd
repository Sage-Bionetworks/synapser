%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{UserProfile}
\alias{UserProfile}
\docType{methods}
\title{
Constructor for objects of type UserProfile
}
\description{
Information about a Synapse user.  In practice the constructor is not called directly by the client.

Attributes:
    ownerId: A foreign key to the ID of the 'principal' object for the user.
    uri: The Uniform Resource Identifier (URI) for this entity.
    etag: Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates.
    Since the E-Tag changes every time an entity is updated it is
    used to detect when a client's current representation
    of an entity is out-of-date.
    firstName: This person's given name (forename)
    lastName: This person's family name (surname)
    emails: The list of user email addresses registered to this user.
    userName: A name chosen by the user that uniquely identifies them.
    summary: A summary description about this person
    position: This person's current position title
    location: This person's location
    industry: The industry/discipline that this person is associated with
    company: This person's current affiliation
    profilePicureFileHandleId: The File Handle ID of the user's profile picture.
    url: A link to more information about this person
    notificationSettings: An object of type [org.sagebionetworks.repo.model.message.Settings](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/message/Settings.html)
    containing the user's preferences regarding when email notifications should be sent
}
\usage{
UserProfile()
}
\arguments{

}
\value{
An object of type UserProfile
}


