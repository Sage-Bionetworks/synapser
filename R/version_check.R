# Utilities for detecting new version
#
# Author: kimyen
###############################################################################

.RAN <- "https://sage-bionetworks.github.io/ran"
.PACKAGE_NAME = "synapser"

# convert the full version to a precision
# precision can be one of the following values:
.MAJOR <- 1
.MINOR <- 2
.PATCH <- 3
.simplifyVersion <- function(version, precision) {
  if (!match(precision, c(.MAJOR, .MINOR, .PATCH))) {
    throw("Invalid precision: ", precision)
  }
  parts <- unlist(strsplit(version, "[.]"))
  parts[is.na(parts[1:precision])] <- "0"
  paste(parts[1:precision], collapse = ".")
}

.printVersionOutOfDateWarnings <- function(current_version, latest_version) {
  message <- sprintf("\nNew synapser version detected:
  You are using synapser version %s.
  synapser version %s is detected at %s.
  To upgrade to the latest version of synapser, please run the following command:
  install.packages(\"synapser\", repos=\"https://sage-bionetworks.github.io/ran\")\n",
                     current_version, latest_version, .RAN)
  packageStartupMessage(message)
}

.checkForUpdate <- function() {
  info <- old.packages(repos = .RAN)
  if (match(.PACKAGE_NAME, rownames(info))) {
    current_version <- .simplifyVersion(info[.PACKAGE_NAME, "Installed"], .MINOR)
    latest_version <- .simplifyVersion(info[.PACKAGE_NAME, "ReposVer"], .MINOR)
    if (current_version < latest_version) {
      .printVersionOutOfDateWarnings(info[.PACKAGE_NAME, "Installed"], info[.PACKAGE_NAME, "ReposVer"])
    }
  }
}

