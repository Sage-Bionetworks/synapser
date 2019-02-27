# Utilities for detecting new version
#
# Author: kimyen
###############################################################################

# convert the full version to a precision
.simplifyVersion <- function(version, precision) {
  if (!(precision %in% c(major = 1, minor = 2, patch = 3))) {
    stop("Invalid precision: ", precision)
  }
  parts <- unlist(strsplit(version, "[.]"))
  parts[is.na(parts[1:precision])] <- "0"
  return(paste(parts[1:precision], collapse = "."))
}

.printVersionOutOfDateWarnings <- function(current_version, latest_version, ran) {
  message <- sprintf("\nNew synapser version detected:
  You are using synapser version %s.
  synapser version %s is detected at %s.
  To upgrade to the latest version of synapser, please run the following command:
  install.packages(\"synapser\", repos=\"https://sage-bionetworks.github.io/ran\")\n",
                     current_version, latest_version, ran)
  packageStartupMessage(message)
}

# check package_name's version against old.packages() output to see if the
# package version is out of date upto the given precision
.isVersionOutOfDate <- function(info, package_name, precision) {
  if (!is(info, "matrix") || !(package_name %in% rownames(info))) {
    return(FALSE)
  }
  current_version <- .simplifyVersion(info[package_name, "Installed"], precision)
  latest_version <- .simplifyVersion(info[package_name, "ReposVer"], precision)
  return(compareVersion(current_version, latest_version) == -1)
}

.checkForUpdate <- function(package = "synapser",
                            ran = "https://sage-bionetworks.github.io/ran",
                            precision = 2) {
  info <- old.packages(repos = ran)
  if (.isVersionOutOfDate(info, package, precision)) {
    .printVersionOutOfDateWarnings(info[package, "Installed"], info[package, "ReposVer"], ran)
  }
}

