# Utilities for detecting new version
#
# Author: kimyen
###############################################################################

# convert the full version to a precision
.simplifyVersion <- function(version, precision) {
  if (length(precision) != 1 || !(precision %in% c(major = 1, minor = 2, patch = 3))) {
    stop("Invalid precision: ", precision)
  }
  parts <- unlist(strsplit(version, "[.]"))
  parts[is.na(parts[1:precision])] <- "0"
  return(paste(parts[1:precision], collapse = "."))
}

.printVersionOutOfDateWarnings <- function(current_version, latest_version, package, repo) {
  message <- sprintf(
    "\nNew %s version detected:
    You are using %s version %s.
    %s version %s is detected at %s.
    To upgrade to the latest version of %s, please run the following command:
    install.packages(\"%s\", repos=c(\"%s\", \"https://cloud.r-project.org\"))\n",
    package,
    package,
    current_version,
    package,
    latest_version,
    repo,
    package,
    package,
    repo
  )
  packageStartupMessage(message)
}

# check package_name's version against old.packages() output to see if the
# package version is out of date upto the given precision
.isVersionOutOfDate <- function(info, package_name, package_version, precision) {
  if (!methods::is(info, "matrix") || !(package_name %in% rownames(info))) {
    return(FALSE)
  }
  current_version <- .simplifyVersion(as.character(package_version), precision)
  latest_version <- .simplifyVersion(info[package_name, "ReposVer"], precision)
  return(compareVersion(current_version, latest_version) == -1)
}

.checkForUpdate <- function(package = "synapser",
                            repo = "https://sage-bionetworks.r-universe.dev",
                            precision = 2) {
  info <- suppressWarnings(old.packages(repos = repo))
  if (.isVersionOutOfDate(info, package, packageVersion(package), precision)) {
    .printVersionOutOfDateWarnings(info[package, "Installed"], info[package, "ReposVer"], package, repo)
  }
}
