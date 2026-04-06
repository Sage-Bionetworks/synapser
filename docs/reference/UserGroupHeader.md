# Constructor for objects of type UserGroupHeader

Select metadata about a Synapse principal. In practice the constructor
is not called directly by the client.

## Usage

``` r
UserGroupHeader(ownerId=NULL, firstName=NULL, lastName=NULL, userName=NULL, email=NULL, isIndividual=NULL)
```

## Arguments

- ownerId:

  optional named parameter: A foreign key to the ID of the 'principal'
  object for the user.  

- firstName:

  optional named parameter: First Name  

- lastName:

  optional named parameter: Last Name  

- userName:

  optional named parameter: A name chosen by the user that uniquely
  identifies them.  

- email:

  optional named parameter: User's current email address  

- isIndividual:

  optional named parameter: TRUE if this is a user, false if it is a
  group

## Value

An object of type UserGroupHeader
