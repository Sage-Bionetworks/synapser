# Constructor for objects of type UserProfile

Information about a Synapse user. In practice the constructor is not
called directly by the client.

## Usage

``` r
UserProfile(ownerId=NULL, uri=NULL, etag=NULL, firstName=NULL, lastName=NULL, emails=NULL, userName=NULL, summary=NULL, position=NULL, location=NULL, industry=NULL, company=NULL, profilePicureFileHandleId=NULL, url=NULL, notificationSettings=NULL)
```

## Arguments

- ownerId:

  optional named parameter: A foreign key to the ID of the 'principal'
  object for the user.  

- uri:

  optional named parameter: The Uniform Resource Identifier (URI) for
  this entity.  

- etag:

  optional named parameter: Synapse employs an Optimistic Concurrency
  Control (OCC) scheme to handle concurrent updates. Since the E-Tag
  changes every time an entity is updated it is used to detect when a
  client's current representation of an entity is out-of-date.  

- firstName:

  optional named parameter: This person's given name (forename)  

- lastName:

  optional named parameter: This person's family name (surname)  

- emails:

  optional named parameter: The list of user email addresses registered
  to this user.  

- userName:

  optional named parameter: A name chosen by the user that uniquely
  identifies them.  

- summary:

  optional named parameter: A summary description about this person  

- position:

  optional named parameter: This person's current position title  

- location:

  optional named parameter: This person's location  

- industry:

  optional named parameter: "The industry/discipline that this person is
  associated with  

- company:

  optional named parameter: This person's current affiliation  

- profilePicureFileHandleId:

  optional named parameter: The File Handle ID of the user's profile
  picture.  

- url:

  optional named parameter: A link to more information about this
  person  

- notificationSettings:

  optional named parameter: An object of type Settings containing the
  user's preferences regarding when email notifications should be sent

## Value

An object of type UserProfile
