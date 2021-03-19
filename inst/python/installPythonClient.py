import sys   
import pip
import os
import gzip
import tarfile
import shutil
import distutils.core
import distutils.log
import platform
from setuptools.command.install import install
import tempfile
import time
import importlib
import pkg_resources
import glob
import zipfile
import inspect
import subprocess
import urllib.request
from patchStdoutStdErr import patch_stdout_stderr

# imported from PythonEmbedInR inst/python
from pip_install import install as pip_install


def localSitePackageFolder(root):
    if os.name=='nt':
        # Windows
        return os.path.join(root, 'Lib', 'site-packages')
    # Mac, Linux
    return os.path.join(root, 'lib', "python{}.{}".format(sys.version_info.major, sys.version_info.minor), 'site-packages')


def addLocalSitePackageToPythonPath(root):
    # clean up sys.path to ensure that synapser does not use user's installed packages
    sys.path = [x for x in sys.path if x.startswith(root) or "PythonEmbedInR" in x]

    sitePackages = localSitePackageFolder(root)
    # PYTHONPATH sets the search path for importing python modules
    if os.environ.get('PYTHONPATH') is not None:
      os.environ['PYTHONPATH'] += os.pathsep+sitePackages
    else:
      os.environ['PYTHONPATH'] = os.pathsep+sitePackages
    sys.path.append(sitePackages)
    # modules with .egg extensions (such as future and synapseClient) need to be explicitly added to the sys.path
    for eggpath in glob.glob(sitePackages+os.sep+'*.egg'):
        os.environ['PYTHONPATH'] += os.pathsep+eggpath
        sys.path.append(eggpath)


SYNAPSE_CLIENT_PACKAGE_NAME = 'synapseclient'
SYNAPSE_CLIENT_PACKAGE_VERSION = '2.2.2'

JINJA_VERSION = '2.11.2'
MARKUPSAFE_VERSION = '1.1.1'

def main(path):
    patch_stdout_stderr()

    path = pkg_resources.normalize_path(path)
    moduleInstallationPrefix=path+os.sep+"inst"

    localSitePackages=localSitePackageFolder(moduleInstallationPrefix)

    addLocalSitePackageToPythonPath(moduleInstallationPrefix)

    os.makedirs(localSitePackages)

    # the least error prone way to install packages at runtime is by invoking
    # pip via a subprocess, although it's not straightforward to do so here.
    for package in (
        'pandas==0.22',

        # we install requests up front because it's a dependency of synapseclient anyway
        # but also comes with certifi which will give us some root CA certs which aren't
        # available otherwise on MacOS on python > 3.6 due to openssl changes
        # and which we'll need to exercise the branch build option below if since we
        # download via https.
        'requests>=2.22.0',
    ):
        pip_install(package, localSitePackages)

    if 'PYTHON_CLIENT_GITHUB_USERNAME' in os.environ and 'PYTHON_CLIENT_GITHUB_BRANCH' in os.environ:
        # install via a branch, development option

        pythonClientGithubUsername = os.environ['PYTHON_CLIENT_GITHUB_USERNAME']
        pythonClientGithubBranch = os.environ['PYTHON_CLIENT_GITHUB_BRANCH']
        archivePrefix="synapsePythonClient-"+pythonClientGithubBranch
        archiveSuffix=".zip"
        url="https://github.com/"+pythonClientGithubUsername+"/synapsePythonClient/archive/"+pythonClientGithubBranch+archiveSuffix
        installPackage(
            "{}-{}".format(SYNAPSE_CLIENT_PACKAGE_NAME, SYNAPSE_CLIENT_PACKAGE_VERSION),
            url,
            archivePrefix,
            archiveSuffix,
            path,
            moduleInstallationPrefix,
        )

    else:
        # if not installing from a branch, install the package via pip
        pip_install("synapseclient=={}".format(SYNAPSE_CLIENT_PACKAGE_VERSION), localSitePackages)

    # check that the installation worked
    addLocalSitePackageToPythonPath(moduleInstallationPrefix)
    import synapseclient

    if platform.system() != 'Windows':
        # on linux and mac we can install these via a pip subprocess...
        for package in (
           "MarkupSafe=={}".format(MARKUPSAFE_VERSION),
           "Jinja2=={}".format(JINJA_VERSION),
        ):
            pip_install(package, localSitePackages)

    else:
        # ...but on windows installing via a subprocess breaks seemingly with the wheel install,
        # so we use the creative sideloading as below.

        # Jinja2 depends on MarkupSafe
        packageName = "MarkupSafe-{}".format(MARKUPSAFE_VERSION)
        linkPrefix = "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/"
        installedPackageFolderName="markupsafe"
        simplePackageInstall(packageName, installedPackageFolderName, linkPrefix, path, localSitePackages)
        addLocalSitePackageToPythonPath(moduleInstallationPrefix)
        #import markupsafe  # This fails intermittently

        packageName = "Jinja2-{}".format(JINJA_VERSION)
        linkPrefix = "https://files.pythonhosted.org/packages/64/a7/45e11eebf2f15bf987c3bc11d37dcc838d9dc81250e67e4c5968f6008b6c/"
        installedPackageFolderName="jinja2"
        simplePackageInstall(packageName, installedPackageFolderName, linkPrefix, path, localSitePackages)
        addLocalSitePackageToPythonPath(moduleInstallationPrefix)
        #import jinja2 # This fails intermittently

    addLocalSitePackageToPythonPath(moduleInstallationPrefix)


# unzip directly into localSitePackages/installedPackageFolderName
# This is a workaround for the cases in which 'pip' and 'setup.py' fail.
# (They fail for MarkupSafe and Jinja2, without providing any info about what went wrong.)
def simplePackageInstall(packageName, installedPackageFolderName, linkPrefix, path, localSitePackages):
    # download 
    zipFileName = packageName + ".tar.gz"
    localZipFile = path+os.sep+zipFileName
    x = urllib.request.urlopen(linkPrefix+zipFileName)
    saveFile = open(localZipFile,'wb')
    saveFile.write(x.read())
    saveFile.close()

    tar = tarfile.open(localZipFile)
    tar.extractall(path=path)
    tar.close()
    os.remove(localZipFile)

    packageDir = path+os.sep+packageName
    os.chdir(packageDir)

    # inside 'packageDir' there's a folder to move to localSitePackages
    shutil.move(os.path.join(packageDir, 'src', installedPackageFolderName), localSitePackages)

    os.chdir(path)
    shutil.rmtree(packageDir)

    sys.path.append(localSitePackages+os.sep+installedPackageFolderName)


def installPackage(packageName, url, archivePrefix, archiveSuffix, path, moduleInstallationPrefix):
    # download 
    zipFileName = archivePrefix + archiveSuffix
    localZipFile = path+os.sep+zipFileName

    # use requests installed dyanmically above to download the archive.
    # with certifi has better SSL support on a Mac for a dynamically installed Python.
    import requests
    with open(localZipFile,'wb') as saveFile, requests.get(url, stream=True) as packageArchive:
        shutil.copyfileobj(packageArchive.raw, saveFile)

    if archiveSuffix==".tar.gz":
        tar = tarfile.open(localZipFile)
        tar.extractall(path=path)
        tar.close()
    elif archiveSuffix==".zip":
        zipFile=zipfile.ZipFile(localZipFile)
        zipFile.extractall(path=path)
        zipFile.close()
    else:
        raise Exception("Unexpected suffix "+suffix)

    os.remove(localZipFile)

    packageDir = path+os.sep+archivePrefix
    os.chdir(packageDir)

    orig_sys_path = sys.path
    orig_sys_argv = sys.argv
    sys.path = ['.'] + sys.path
    sys.argv = ['setup.py', 'install', '--prefix='+moduleInstallationPrefix]

    try:
        importlib.import_module("setup")
    finally:
        sys.path=orig_sys_path
        sys.argv=orig_sys_argv
        # leave the folder we're about to delete
        os.chdir(path)
        shutil.rmtree(packageDir)



