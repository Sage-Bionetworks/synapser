##
## build the artifacts and install the package
## for the active R version

set -e
##
## install the dependencies, first making sure there are none in the default path
##
if [ ${USE_STAGING_RAN} ]
then
	RAN=https://sage-bionetworks.github.io/staging-ran
else
	RAN=https://sage-bionetworks.github.io/ran
fi

## create the temporary library directory
# TODO If we were to run multiple executors, this could cause a collision.
# TODO A better approach is to use the job name or to create a unique, temporary folder.
# make sure nothing was left from the previous build
rm -rf ../RLIB
mkdir -p ../RLIB

## install the dependencies
R -e "try(remove.packages('synapser'), silent=T);\
try(remove.packages('PythonEmbedInR'), silent=T);\
install.packages(c('pack', 'R6', 'testthat', 'knitr', 'rmarkdown', 'PythonEmbedInR', 'rjson'),\
 repos=c('http://cran.fhcrc.org', '${RAN}'))"

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
echo "apiKey=${APIKEY}" >> orig.synapseConfig
# store synapse base endpoint
echo ${SYNAPSE_BASE_ENDPOINT}
echo "[endpoints]" > orig.synapseConfig
echo "repoEndpoint=${SYNAPSE_BASE_ENDPOINT}/repo/v1" >> orig.synapseConfig
echo "authEndpoint=${SYNAPSE_BASE_ENDPOINT}/auth/v1" >> orig.synapseConfig
echo "fileHandleEndpoint=${SYNAPSE_BASE_ENDPOINT}/file/v1" >> orig.synapseConfig

## Now build/install the package
if [ $label = ubuntu ] || [ $label = ubuntu-remote ]; then
  mv orig.synapseConfig ~/.synapseConfig
  
  ## build the package, including the vignettes
  R CMD build ./

  ## now install it, creating the deployable archive as a side effect
  R CMD INSTALL ./ --library=../RLIB
  
  CREATED_ARCHIVE=${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz
  
  if [ ! -f ${CREATED_ARCHIVE} ]; then
  	echo "Linux artifact was not created"
  	exit 1
  fi
elif [ $label = osx ] || [ $label = osx-lion ] || [ $label = osx-leopard ] || [ $label = MacOS-10.11 ]; then
  mv orig.synapseConfig ~/.synapseConfig
  ## build the package, including the vignettes
  # for some reason latex is not on the path.  So we add it.
  export PATH="$PATH:/usr/texbin"
  # make sure there are no stray .tar.gz files
  rm -f ${PACKAGE_NAME}*.tar.gz
  rm -f ${PACKAGE_NAME}*.tgz
  
  R CMD build ./
  # now there should be exactly one *.tar.gz file

  ## build the binary for MacOS
  R CMD INSTALL --build ${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz --library=../RLIB

  if [ -f ../RLIB/${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so ]; then
    ## Now fix the binaries, per SYNR-341:
    mkdir -p ${PACKAGE_NAME}/libs
    cp ../RLIB/${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so ${PACKAGE_NAME}/libs
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
elif  [ $label = windows-aws ]; then
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
  
  echo "next step is R CMD build ./"
  
  R CMD build ./
  # now there should be exactly one *.tar.gz file

  echo "next step is R CMD INSTALL --build..."
  
  ## build the binary for Windows
  # omitting "--no-test-load" causes the error: "Error : package 'PythonEmbedInR' is not installed for 'arch = i386'"
  R CMD INSTALL --build ${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz --library=../RLIB --no-test-load
  
  # for some reason Windows fails to create synapser_<version>.zip
  ZIP_TARGET_NAME=${PACKAGE_NAME}_${PACKAGE_VERSION}.zip
  if [ ! -f ${ZIP_TARGET_NAME} ]; then
    echo ${ZIP_TARGET_NAME} 'is not found.  Will zip the package now.'
    PWD=`pwd`
    cd ../RLIB
    zip -r9Xq ${ZIP_TARGET_NAME} ${PACKAGE_NAME}
    cd ${PWD}
    mv ../RLIB/${ZIP_TARGET_NAME} .
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

R -e ".libPaths('../RLIB');\
      library('synapser');\
      synLogin()"
##  setwd(sprintf('%s/tests', getwd()));\
##  source('testthat.R')"

## clean up the temporary R library dir
rm -rf ../RLIB

