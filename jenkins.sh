#!/bin/bash
##
## build the artifacts and install the package
## for the active R version

set -e

function install_required_packages {
  echo "print(.libPaths())" >> installPackages.R
  echo "try(remove.packages('synapser'), silent=T)" > installPackages.R
  echo "install.packages(c('pack', 'R6', 'testthat', 'knitr', 'rmarkdown', 'reticulate'), " >> installPackages.R

  # we use no-lock throughout. there should never be two executors running on the same
  # label at the same time, but if we use locks an aborted jenkins build can leave stale
  # locks that will break subsequent builds until cleaned up.
  echo "repos=c('http://ran.synapse.org', '${RAN}'), INSTALL_opts='--no-lock')" >> installPackages.R
  R --vanilla < installPackages.R
  rm installPackages.R
}

## export the jenkins-defined environment variables
export label
export RVERS=$(echo $label | awk -F[-] '{print $3}')

# directory into which we can install libraries. we want it in the job
# workspace so it doesn't collide with other running jobs
RLIB_DIR="./RLIB"
rm -rf $RLIB_DIR
mkdir -p $RLIB_DIR

PACKAGE_NAME=synapser

# if version is specified, build the given version
if [ -n ${VERSION} ]
then
  DATE=`date +%Y-%m-%d`
  # replace DESCRIPTION with $VERSION & $DATE
  sed "s|^Version: .*$|Version: $VERSION|g" DESCRIPTION > DESCRIPTION.temp
  sed "s|^Date: .*$|Date: $DATE|g" DESCRIPTION.temp > DESCRIPTION2.temp

  rm DESCRIPTION
  mv DESCRIPTION2.temp DESCRIPTION
  rm DESCRIPTION.temp

  # replace man/synapser-package.Rd with $VERSION & $DATE
  sed "s|^Version: .*$|Version: \\\tab $VERSION\\\cr|g" man/synapser-package.Rd > man/synapser-package.Rd.temp
  sed "s|^Date: .*$|Date: \\\tab $DATE\\\cr|g" man/synapser-package.Rd.temp > man/synapser-package.Rd2.temp

  rm man/synapser-package.Rd
  mv man/synapser-package.Rd2.temp man/synapser-package.Rd
  rm man/synapser-package.Rd.temp
fi

export PACKAGE_VERSION=`grep Version DESCRIPTION | awk '{print $2}'`

# Warning: This step only works because we never run 2 concurrent builds on the same machine.

# store the login credentials
echo "[authentication]" > orig.synapseConfig
echo "username=${USERNAME}" >> orig.synapseConfig
echo "password=${PASSWORD}" >> orig.synapseConfig
# store synapse base endpoint
echo "[endpoints]" >> orig.synapseConfig
echo "repoEndpoint=${SYNAPSE_BASE_ENDPOINT}/repo/v1" >> orig.synapseConfig
echo "authEndpoint=${SYNAPSE_BASE_ENDPOINT}/auth/v1" >> orig.synapseConfig
echo "fileHandleEndpoint=${SYNAPSE_BASE_ENDPOINT}/file/v1" >> orig.synapseConfig

# helper function we can use in various OSes to set the PATH
# appropriately for the version we want to run
function get_R_PATH {
  GUESSED_OS_PATH=$1

  set +e
  FOUND_PATH=$(ls -d $GUESSED_OS_PATH)
  if [ -n "$FOUND_PATH" ]; then
    echo "$(dirname $FOUND_PATH):${PATH}"
  else
    echo $PATH
  fi
  set -e
}

## Now build/install the package
if [[ $label = $LINUX_LABEL_PREFIX* ]]; then
  # remove previous build .synapseCache
  set +e
  rm -rf ~/.synapseCache
  set -e
  mv orig.synapseConfig ~/.synapseConfig

  export PATH=$(get_R_PATH "/usr/local/R/R-${RVERS}*/bin/R")
  install_required_packages

  ## build the package, including the vignettes
  R CMD build ./

  ## now install it, creating the deployable archive as a side effect
  R CMD INSTALL --no-lock ./ --library=$RLIB_DIR

  CREATED_ARCHIVE=${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz

  if [ ! -f ${CREATED_ARCHIVE} ]; then
    echo "Linux artifact was not created"
    exit 1
  fi
elif [[ $label = $MAC_LABEL_PREFIX* ]]; then
  # if we're using R versions installed from pkg installers
  # then we need to switch version symlinks.
  # note that we can only build one R package/version at a time
  # per jenkins slave in this case.
  R_FRAMEWORK_DIR="/Library/Frameworks/R.framework/Versions"
  if [ -L "$R_FRAMEWORK_DIR/Current" ]; then
    rm "$R_FRAMEWORK_DIR/Current"
    ln -s "$R_FRAMEWORK_DIR/$RVERS" "$R_FRAMEWORK_DIR/Current"
  fi

  # remove previous build .synapseCache
  set +e
  rm -rf ~/.synapseCache
  set -e
  mv orig.synapseConfig ~/.synapseConfig

  ## build the package, including the vignettes
  # for some reason latex is not on the path.  So we add it.
  export PATH="$PATH:/usr/texbin"
  # make sure there are no stray .tar.gz files
  rm -f ${PACKAGE_NAME}*.tar.gz
  rm -f ${PACKAGE_NAME}*.tgz

  export PATH=$(get_R_PATH "/usr/local/R/R-${RVERS}*/bin/R")
  install_required_packages

  R CMD build ./
  # now there should be exactly one *.tar.gz file

  ## build the binary for MacOS
  R CMD INSTALL --no-lock --build ${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz --library=$RLIB_DIR

  if [ -f $RLIB_DIR/${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so ]; then
    ## Now fix the binaries, per SYNR-341:
    mkdir -p ${PACKAGE_NAME}/libs
    cp $RLIB_DIR/${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so ${PACKAGE_NAME}/libs
    install_name_tool -change "/Library/Frameworks/R.framework/Versions/$RVERS/Resources/lib/libR.dylib"  "/Library/Frameworks/R.framework/Versions/Current/Resources/lib/libR.dylib" ${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so

    # update archive with modified binaries
    for f in *.tgz
    do
	  prefix="${f%.*}"
	  gunzip "$f"
	  # Note, >=3.0 there is only one platform
	  tar -rf "$prefix".tar ${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so
	  rm "$prefix".tar.gz
	  gzip "$prefix".tar
	  mv "$prefix".tar.gz "$prefix".tgz
    done
  fi

  ## Following what we do in the Windows build, remove the source package if it remains
  set +e
  rm ${PACKAGE_NAME}*.tar.gz
  set -e

  CREATED_ARCHIVE=${PACKAGE_NAME}_${PACKAGE_VERSION}.tgz

  if [ ! -f  ${CREATED_ARCHIVE} ]; then
  	echo "osx artifact was not created"
  	exit 1
  fi
elif  [[ $label = $WINDOWS_LABEL_PREFIX* ]]; then
  # remove previous build .synapseCache
  set +e
  rm -rf /c/Users/Administrator/.synapseCache
  set -e
  # for some reason "~" is not recognized.  As a workaround we "hard code" /c/Users/Administrator
  mv orig.synapseConfig /c/Users/Administrator/.synapseConfig
  export TZ=UTC

  ## build the package, including the vignettes
  # for some reason latex is not on the path.  So we add it.
  export PATH="$PATH:/cygdrive/c/Program Files/MiKTeX 2.9/miktex/bin/x64"
  # make sure there are no stray .tar.gz files
  # 'set +e' keeps the script from terminating if there are no .tgz files
  set +e
  rm ${PACKAGE_NAME}*.tar.gz
  rm ${PACKAGE_NAME}*.tgz
  set -e

  export PATH=$(get_R_PATH "/c/R/R-${RVERS}*/bin/R")
  install_required_packages

  R CMD build ./
  # now there should be exactly one *.tar.gz file

  ## build the binary for Windows
  # previously, omitting "--no-test-load" may causes the error: "Error : package 'PythonEmbedInR' is not installed for 'arch = i386'"
  # PythonEmbedInR is no longer a dependency, so it may be safe to remove
  R CMD INSTALL --no-lock --build ${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz --library=$RLIB_DIR --no-test-load

  # for some reason Windows fails to create synapser_<version>.zip
  ZIP_TARGET_NAME=${PACKAGE_NAME}_${PACKAGE_VERSION}.zip
  if [ ! -f ${ZIP_TARGET_NAME} ]; then
    echo ${ZIP_TARGET_NAME} 'is not found.  Will zip the package now.'

    PWD=`pwd`
    cd $RLIB_DIR
    zip -r9Xq ${ZIP_TARGET_NAME} ${PACKAGE_NAME}
    cd ${PWD}
    mv $RLIB_DIR/${ZIP_TARGET_NAME} .
  fi

  ## This is very important, otherwise the source packages from the windows build overwrite
  ## the ones created on the unix machine.
  rm -f ${PACKAGE_NAME}*.tar.gz

  CREATED_ARCHIVE=${ZIP_TARGET_NAME}

  if [ ! -f  ${CREATED_ARCHIVE} ]; then
    echo "Windows artifact was not created"
    exit 1
  fi
else
  echo "*** UNRECOGNIZED LABEL: $label ***"
  exit 1
fi

echo ".libPaths(c('$RLIB_DIR', .libPaths()))" > runTests.R
echo "setwd(sprintf('%s/tests', getwd()))" >> runTests.R
echo "source('testthat.R')" >> runTests.R
R --vanilla < runTests.R
rm runTests.R

echo ".libPaths(c('$RLIB_DIR', .libPaths()))" > testRscript.R
echo "library(\"synapser\")" >> testRscript.R
echo "synLogin()" >> testRscript.R
Rscript testRscript.R
rm testRscript.R

## clean up the temporary R library dir
rm -rf $RLIB_DIR

