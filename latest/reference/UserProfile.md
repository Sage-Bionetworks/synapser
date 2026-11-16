# UserProfile

UserProfile represents a user's profile in the system.

## Usage

``` r
UserProfile(id=NULL, username=NULL, etag=NULL, first_name=NULL, last_name=NULL, emails=list(), open_ids=list(), r_studio_url=NULL, summary=NULL, position=NULL, location=NULL, industry=NULL, company=NULL, profile_picure_file_handle_id=NULL, url=NULL, team_name=NULL, send_email_notifications=TRUE, mark_emailed_messages_as_read=FALSE, preferences=list(), created_on=NULL, display_name=NULL, notification_settings=NULL)
```

## Format

An S3-style class object.

## Arguments

- id:

  (Optional\[int\]) A foreign key to the ID of the 'principal' object
  for the user.

- username:

  (Optional\[str\]) A name chosen by the user that uniquely identifies
  them.

- etag:

  (Optional\[str\]) Synapse employs an Optimistic Concurrency Control
  (OCC) scheme to handle concurrent updates. Since the E-Tag changes
  every time an entity is updated it is used to detect when a client's
  current representation of an entity is out-of-date.

- first_name:

  (Optional\[str\]) This person's given name (forename)

- last_name:

  (Optional\[str\]) This person's family name (surname)

- emails:

  (list\[str\]) The list of user email addresses registered to this
  user.

- open_ids:

  (list\[str\]) The list of OpenIds bound to this user's account.

- r_studio_url:

  (Optional\[str\]) URL for RStudio server assigned to the user.

- summary:

  (Optional\[str\]) A summary description about this person.

- position:

  (Optional\[str\]) This person's current position title.

- location:

  (Optional\[str\]) This person's location.

- industry:

  (Optional\[str\]) The industry/discipline that this person is
  associated with.

- company:

  (Optional\[str\]) This person's current affiliation.

- profile_picure_file_handle_id:

  (Optional\[str\]) The File Handle id of the user's profile picture.

- url:

  (Optional\[str\]) A link to more information about this person.

- team_name:

  (Optional\[str\]) This person's default team name.

- send_email_notifications:

  (Optional\[bool\]) Should the user receive email notifications?
  Default TRUE.

- mark_emailed_messages_as_read:

  (Optional\[bool\]) Should messages that are emailed to the user be
  marked as READ in Synapse? Default FALSE.

- preferences:

  (Optional\[list\[UserPreference\]\]) A list of
  [`UserPreference`](https://r-docs.synapse.org/latest/reference/UserPreference.md)
  objects.

- created_on:

  (Optional\[str\]) The date this profile was created.

- display_name:

  This field is deprecated and will always be NULL.

- notification_settings:

  Contains a user's notification settings.

## Value

NULL

## Methods

- `UserProfile(id=NULL, username=NULL, etag=NULL, first_name=NULL, last_name=NULL, emails=list(), open_ids=list(), r_studio_url=NULL, summary=NULL, position=NULL, location=NULL, industry=NULL, company=NULL, profile_picure_file_handle_id=NULL, url=NULL, team_name=NULL, send_email_notifications=TRUE, mark_emailed_messages_as_read=FALSE, preferences=list(), created_on=NULL, display_name=NULL, notification_settings=NULL)`:
  Constructor for `UserProfile`

- [`synGetFromId`](https://r-docs.synapse.org/latest/reference/UserProfile_GetFromId.md)`(cls, user_id, synapse_client=NULL)`:
  Gets UserProfile object using its integer id.

- [`synGetFromUsername`](https://r-docs.synapse.org/latest/reference/UserProfile_GetFromUsername.md)`(cls, username, synapse_client=NULL)`:
  Gets UserProfile object using its string name.

- [`synIsCertified`](https://r-docs.synapse.org/latest/reference/UserProfile_IsCertified.md)`(instance, synapse_client=NULL)`:
  Determine whether a user is certified.

## Examples

``` r
if (FALSE) { # \dontrun{
## Getting a user's profile
    library(synapser)
    synLogin()

    profile = UserProfile |> synGetFromUsername(username = "myUsername")
    print(profile$id)

    profile = UserProfile |> synGetFromId(user_id = 273948L)
    print(profile$username)

    # Or fill in a UserProfile that already has an id or a username.
    # If both are set, the id is used.
    profile = UserProfile(id = 273948L) |> synGet()
    profile = UserProfile(username = "myUsername") |> synGet()

    # With neither set, you get the profile of the logged-in user
    my_profile = UserProfile() |> synGet()

    # Check whether the user is certified
    print(profile |> synIsCertified())
} # }
```
