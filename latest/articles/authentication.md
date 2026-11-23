# Authentication

There are multiple ways one can login to Synapse. We recommend users
choose the method that fits their workflow best.

## Prerequisites

- Create a [Personal Access
  Token](https://help.synapse.org/docs/Managing-Your-Account.2055405596.html#ManagingYourAccount-PersonalAccessTokens)
  (**aka: Synapse Auth Token**) obtained from synapse.org under your
  Settings.
  - Note that a token must minimally have the **view** scope to be used
    with the Synapse R Client.
  - Include **Download** and **Modify** permissions if you are using the
    Synapse R Client to follow any subsequent tutorials.
- Once a personal access token has been created it can be used for any
  of the options below.

**Note:** Credentials are looked up in this order: arguments passed to
[`synLogin()`](https://r-docs.synapse.org/latest/reference/synLogin.md),
then the `~/.synapseConfig` file, then the `SYNAPSE_AUTH_TOKEN`
environment variable.

## One Time Login

Use the
[`synLogin()`](https://r-docs.synapse.org/latest/reference/synLogin.md)
function.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``authToken ``=`` ``"authtoken"``)`\
`# Prints: Welcome, First Last!`

## Use Environment Variable

Setting the `SYNAPSE_AUTH_TOKEN` environment variable will allow you to
login to Synapse with a [Personal Access
Token](https://docs.synapse.org/synapse-docs/managing-your-account#Personal-Access-Tokens-(PATs))

To make the variable available in the R session, add it to your
`~/.Renviron` file. R reads this file each time it starts.

1.  Open the file. If you have the `usethis` package, run the following
    in R; it creates the file if it doesn’t exist and opens it for
    editing:

    \
    `usethis``::``edit_r_environ``(``)`

    Otherwise, open `~/.Renviron` in any text editor.

2.  Add this line, replacing the placeholder with your token, and save
    the file. Make sure the file ends with a newline.

        SYNAPSE_AUTH_TOKEN=<my_personal_access_token>

3.  Restart R (in RStudio: **Session \> Restart R**), then log in:

    \
    [`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
    [`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`

Because `.Renviron` contains your token, keep it out of version control.
If you use a project-level `.Renviron` inside a git repository, add it
to the repository’s `.gitignore`. If you have the `usethis` package,
`usethis::use_git_ignore(".Renviron")` adds the entry for you.

## Use `.synapseConfig`

For writing code using the Synapse R Client (`synapser`) that is easy to
share with others, please do not include your credentials in the code.
Instead, please use the `~/.synapseConfig` file to manage your
credentials.

The Synapse R Client supports multiple profiles within the
`~/.synapseConfig` file, enabling users to manage credentials for
multiple accounts. Each profile is defined in its own
`[profile <profile_name>]` section. A default profile can still be
defined using `[default]`.

### Editing the `~/.synapseConfig` file

Open the `~/.synapseConfig` file using your preferred text editing tool
and find/insert the following section(s):

    [default]
    username = default_user
    authtoken = default_auth_token

    [profile user1]
    username = user1
    authtoken = user1_auth_token

    [profile user2]
    username = user2
    authtoken = user2_auth_token

    # This section is deprecated. It will be used if a `default` profile or a specific profile is not present in the config file
    #[authentication]
    #username = default_user
    #authtoken = default_auth_token

`username` is optional when using `authtoken`, but if provided, an
additional check to verify the `authtoken` matches the `username` is
performed.

The `authtoken` is also known as a personal access token. It is
generated from your [synapse.org
Settings](https://help.synapse.org/docs/Managing-Your-Account.2055405596.html#ManagingYourAccount-PersonalAccessTokens).

### Transitioning from One Profile to Multiple

If you’re currently using a single profile (under the `[default]` or
`[authentication]` section) and wish to start using multiple profiles,
simply add new sections for each profile with a unique profile name. For
example, you can add a profile for user1 and user2 as shown below. The
Synapse R Client will allow you to choose which profile to use at login.

    [default]
    username = default_user
    authtoken = default_auth_token

    [profile user1]
    username = user1
    authtoken = user1_auth_token

    [profile user2]
    username = user2
    authtoken = user2_auth_token

## Logging in with your ~/.synapseConfig file

**Note:** If no profile is specified the `default` section will be used.
Additionally, to support backwards compatibility, `authentication` will
continue to function. `authentication` will be used if no profile is
used and `default` is not present in the configuration file.

### Logging in via R

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`

If you want to log in with a specific profile, simply pass the profile
name as an argument to
[`synLogin()`](https://r-docs.synapse.org/latest/reference/synLogin.md):

\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``profile ``=`` ``"user1"``)`

### For more information, see:

- [synLogin](https://r-docs.synapse.org/latest/reference/synLogin.md)
- [synLogout](https://r-docs.synapse.org/latest/reference/synLogout.md)
- [synapse
  config](https://r-docs.synapse.org/latest/articles/configuration.md)
