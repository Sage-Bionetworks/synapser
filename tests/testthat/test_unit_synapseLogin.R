## Unit test synapseLogin
## 
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################

.setUp <-
  function()
{
  synapseClient:::.setCache('oldSessionToken', synapseClient:::.getCache("sessionToken"))
  synapseClient:::.setCache('oldHmacKey', synapseClient:::.getCache("hmacSecretKey"))
  synapseClient:::sessionToken(NULL)
  hmacSecretKey(NULL)
  
  # Disable the welcome message
  synapseClient:::.mock(".doWelcome", function(...) {})
}

.tearDown <- function() {
    synapseClient:::sessionToken(synapseClient:::.getCache('oldSessionToken'))
    hmacSecretKey(synapseClient:::.getCache('oldHmacKey'))
    
    synapseClient:::.unmockAll()
}

unitTestNotLoggedInHmac <- function() {
  gotException <- FALSE
  tryCatch(getEntity(Project(list(id='bar'))),
    error = function(e) {
      gotException <<- TRUE
      checkTrue(grepl("Please authenticate", e))
    }
  )
  checkTrue(gotException)
}

unitTestDoAuth_username_password <- function() {
    ## TODO: remove this test?  It doesn't test much.
    credentials = list(username="foo", password="bar", sessionToken="", apiKey="")
    
    # These will be called if the logic is correct
    getSessionToken_called <- FALSE
    doHmac_called <- FALSE
    synapseClient:::.mock(".getSessionToken", function(...) {getSessionToken_called <<- TRUE})
    synapseClient:::.mock(".doHmac", function(...) {doHmac_called <<- TRUE})
    
    # These will not be called if the logic is correct
    hmacSecretKey_called <- FALSE
    refreshSessionToken_called <- FALSE
    readSessionCache_called <- FALSE
    synapseClient:::.mock("hmacSecretKey", function(...) {hmacSecretKey_called <<- TRUE})
    synapseClient:::.mock(".refreshSessionToken", function(...) {refreshSessionToken_called <<- TRUE})
    synapseClient:::.mock(".readSessionCache", function(...) {readSessionCache_called <<- TRUE})
    
    # Perform the call and check
    synapseClient:::.doAuth(credentials)
    checkTrue(getSessionToken_called)
    checkTrue(doHmac_called)
    checkTrue(!hmacSecretKey_called)
    checkTrue(!refreshSessionToken_called)
    checkTrue(!readSessionCache_called)
}

unitTestDoAuth_most_recent <- function() {
    credentials = list(username="", password="", sessionToken="", apiKey="")
    
    # These will be called if the logic is correct
    readSessionCache_called <- FALSE
    userName_called <- FALSE
    hmacSecretKey_called <- FALSE
    synapseClient:::.mock(".readSessionCache", 
        function(...) {
            readSessionCache_called <<- TRUE
            username <- "foo"
            json <- list()
            json[[username]] <- "api key"
            json[['<mostRecent>']] <- "foo"
            return(json)
        }
    )
    synapseClient:::.mock("userName", function(...) {userName_called <<- TRUE})
    synapseClient:::.mock("hmacSecretKey", function(...) {hmacSecretKey_called <<- TRUE})
    
    # These will not be called if the logic is correct
    configParser_called <- FALSE
    synapseClient:::.mock("ConfigParser", function(...) {configParser_called <<- TRUE})
    
    synapseClient:::.doAuth(credentials)
    checkTrue(readSessionCache_called)
    checkTrue(userName_called)
    checkTrue(hmacSecretKey_called)
    checkTrue(!configParser_called)
}

unitTestDoAuth_session_and_config <- function() {
    credentials = list(username="", password="", sessionToken="", apiKey="")
    
    # These will be called if the logic is correct
    readSessionCache_called <- FALSE
    configParser_called <- FALSE
    hasOption_called_correctly <- FALSE
    synapseClient:::.mock(".readSessionCache", 
        function(...) {
            readSessionCache_called <<- TRUE
            return(list(foo="api key"))
        }
    )
    synapseClient:::.mock("ConfigParser", function(...) {configParser_called <<- TRUE})
    synapseClient:::.mock("Config.hasOption", 
        function(ignore, section, option) {
            hasOption_called_correctly <<- all(section == "authentication" && option == "username")
            return(hasOption_called_correctly)
        }
    )
    synapseClient:::.mock("Config.getOption", 
        function(ignore, section, option) {
            if (all(section == "authentication" && option == "username")) {
                return("foo")
            }
            stop(sprintf("Incorrect arguments to Config.getOption: %s, %s", section, option))
        }
    )
    
    synapseClient:::.doAuth(credentials)
    checkTrue(readSessionCache_called)
    checkTrue(configParser_called)
    checkTrue(hasOption_called_correctly)
}

unitTest_logout <- function() {
    synapseClient:::userName("foo")
    synapseClient:::sessionToken("bar")
    synapseClient:::hmacSecretKey("baz")
    synapseDelete_called <- FALSE
    synapseClient:::.mock("synapseDelete", function(...) {synapseDelete_called <<- TRUE})
    
    synapseLogout(silent=TRUE)
    checkTrue(is.null(synapseClient:::userName()))
    checkTrue(is.null(synapseClient:::sessionToken()))
    checkTrue(class(try(synapseClient:::hmacSecretKey(), silent=TRUE)) == "try-error")
    checkTrue(synapseDelete_called)
    
    # Try again without the session token
    synapseClient:::userName("foo")
    synapseClient:::hmacSecretKey("baz")
    synapseDelete_called <- FALSE
    
    synapseLogout(silent=TRUE)
    checkTrue(is.null(synapseClient:::userName()))
    checkTrue(is.null(synapseClient:::sessionToken()))
    checkTrue(class(try(synapseClient:::hmacSecretKey(), silent=TRUE)) == "try-error")
    checkTrue(!synapseDelete_called)
}

unitTest_loginNoConfigFile <- function() {
    credentials = list(username="", password="", sessionToken="", apiKey="")
    
    readSessionCache_called <- FALSE
    synapseClient:::.mock(".readSessionCache", 
        function(...) {
            readSessionCache_called <<- TRUE
            return(list(totally="ignored"))
        }
    )
    
    configParser_called <- FALSE
    synapseClient:::.mock("ConfigParser", 
        function(...) {
            configParser_called <<- TRUE
            synapseClient:::.getMockedFunction("ConfigParser")()
        }
    )
    synapseClient:::.mock(".checkAndReadFile", function(...) {stop("Mwhaha!  No config file here!")})
    
    doTkLogin_called <- FALSE
    doTerminalLogin_called <- FALSE
    synapseClient:::.mock(".doTkLogin", function(...) {doTkLogin_called <<- TRUE})
    synapseClient:::.mock(".doTerminalLogin", function(...) {doTerminalLogin_called <<- TRUE})
    
    synapseClient:::.doAuth(credentials)
    checkTrue(readSessionCache_called)
    checkTrue(configParser_called)
    checkTrue(doTkLogin_called || doTerminalLogin_called)
}
