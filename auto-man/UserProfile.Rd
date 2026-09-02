%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{UserProfile}
\alias{UserProfile}
\docType{class}
\title{
UserProfile
}
\format{An S3-style class object.}
\description{
UserProfile represents a user's profile in the system.
}
\usage{
UserProfile(id=NULL, username=NULL, etag=NULL, first_name=NULL, last_name=NULL, emails=list(), open_ids=list(), r_studio_url=NULL, summary=NULL, position=NULL, location=NULL, industry=NULL, company=NULL, profile_picure_file_handle_id=NULL, url=NULL, team_name=NULL, send_email_notifications=TRUE, mark_emailed_messages_as_read=FALSE, preferences=list(), created_on=NULL, display_name=NULL, notification_settings=NULL)
}
\arguments{
\item{id}{(Optional[int]) A foreign key to the ID of the 'principal' object for the user.}
\item{username}{(Optional[str]) A name chosen by the user that uniquely identifies them.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{first_name}{(Optional[str]) This person's given name (forename)}
\item{last_name}{(Optional[str]) This person's family name (surname)}
\item{emails}{(list[str]) The list of user email addresses registered to this user.}
\item{open_ids}{(list[str]) The list of OpenIds bound to this user's account.}
\item{r_studio_url}{(Optional[str]) URL for RStudio server assigned to the user.}
\item{summary}{(Optional[str]) A summary description about this person.}
\item{position}{(Optional[str]) This person's current position title.}
\item{location}{(Optional[str]) This person's location.}
\item{industry}{(Optional[str]) The industry/discipline that this person is associated with.}
\item{company}{(Optional[str]) This person's current affiliation.}
\item{profile_picure_file_handle_id}{(Optional[str]) The File Handle id of the user's profile picture.}
\item{url}{(Optional[str]) A link to more information about this person.}
\item{team_name}{(Optional[str]) This person's default team name.}
\item{send_email_notifications}{}
\item{mark_emailed_messages_as_read}{}
\item{preferences}{(Optional[list[UserPreference]]) User preferences}
\item{created_on}{(Optional[str]) The date this profile was created.}
\item{display_name}{optional named parameter: This field is deprecated and will always be null.}
\item{notification_settings}{optional named parameter: Contains a user's notification settings.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{UserProfile(id=NULL, username=NULL, etag=NULL, first_name=NULL, last_name=NULL, emails=list(), open_ids=list(), r_studio_url=NULL, summary=NULL, position=NULL, location=NULL, industry=NULL, company=NULL, profile_picure_file_handle_id=NULL, url=NULL, team_name=NULL, send_email_notifications=TRUE, mark_emailed_messages_as_read=FALSE, preferences=list(), created_on=NULL, display_name=NULL, notification_settings=NULL)}: Constructor for \code{\link{UserProfile}}
\item \code{from_id(cls, user_id, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{from_username(cls, username, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{is_certified(synapse_client=NULL)}: Wrapper for the function to be traced.
}
}

