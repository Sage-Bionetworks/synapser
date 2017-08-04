##
## build the artifacts and install the package
## for the active R version

## create the temporary library directory
# TODO If we were to run multiple executors, this could cause a collision.
# TODO A better approach is to use the job name or to create a unique, temporary folder.
mkdir -p ../RLIB

## export the jenkins-defined environment variables
export label
export RVERS

export PACKAGE_NAME=synapser

# store the login credentials
echo "[authentication]" > orig.synapseConfig
echo "username=${USERNAME}" >> orig.synapseConfig
echo "apiKey=${APIKEY}" >> orig.synapseConfig


## Now build/install the package
if [ $label = ubuntu ] || [ $label = ubuntu-remote ]
then
  mv orig.synapseConfig ~/.synapseConfig
  ## build the package, including the vignettes
  R CMD build ./

  ## now install it
  R CMD INSTALL ./ --library=../RLIB --no-test-load
elif [ $label = osx ] || [ $label = osx-lion ] || [ $label = osx-leopard ]
then
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
  for f in ${PACKAGE_NAME}*.tar.gz
  do
     R CMD INSTALL --build "$f" --library=../RLIB --no-test-load
  done

  if [ -f ../RLIB/${PACKAGE_NAME}/libs/${PACKAGE_NAME}.so ]
  then
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
elif  [ $label = windows-aws ]
then
  # for some reason "~" is not recognized.  As a workaround we "hard code" /Users/Administrator
  mv orig.synapseConfig /home/Administrator/.synapseConfig
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
  
  R CMD build ./
  # now there should be exactly one *.tar.gz file

  ## build the binary for Windows
  for f in ${PACKAGE_NAME}*.tar.gz
  do
     R CMD INSTALL --build "$f" --library=../RLIB --no-test-load
  done
  
  # for some reason Windows fails to create synapser_<version>.zip
  PACKAGE_VERSION=`grep Version DESCRIPTION | awk '{print $2}'`
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
else
  echo "*** UNRECOGNIZED LABEL: $label ***"
  exit 1
fi

## clean up the temporary R library dir
rm -rf ../RLIB
