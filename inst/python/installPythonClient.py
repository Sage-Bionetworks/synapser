import sys   
import pip
import os
import urllib
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
from stdouterrCapture import stdouterrCapture

def localSitePackageFolder(root):
    if os.name=='nt':
        # Windows
        return root+os.sep+"Lib"+os.sep+"site-packages"
    else:
        # Mac, Linux
        return root+os.sep+"lib"+os.sep+"python3.5"+os.sep+"site-packages"
    
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
    
def main(path):
    path = pkg_resources.normalize_path(path)
    moduleInstallationPrefix=path+os.sep+"inst"

    localSitePackages=localSitePackageFolder(moduleInstallationPrefix)
    
    addLocalSitePackageToPythonPath(moduleInstallationPrefix)

    os.makedirs(localSitePackages)
    
    # The preferred approach to install a package is to use pip...
    # stdouterrCapture(lambda: call_pip('pip')) # (can even use pip to update pip itself)
    stdouterrCapture(lambda: call_pip('pandas', localSitePackages), abbreviateStackTrace=False)
#     # check that the installation worked
#    addLocalSitePackageToPythonPath(moduleInstallationPrefix)
#     import pandas# This fails intermittently

    # ...but - for some reason - pip breaks when we install the python synapse client
    # So we use 'setup' directly
    packageName = "synapseclient-1.8.1"
    
    if 'PYTHON_CLIENT_GITHUB_USERNAME' in os.environ and 'PYTHON_CLIENT_GITHUB_BRANCH' in os.environ:
        pythonClientGithubUsername = os.environ['PYTHON_CLIENT_GITHUB_USERNAME']
        pythonClientGithubBranch = os.environ['PYTHON_CLIENT_GITHUB_BRANCH']
        archivePrefix="synapsePythonClient-"+pythonClientGithubBranch
        archiveSuffix=".zip"
        url="https://github.com/"+pythonClientGithubUsername+"/synapsePythonClient/archive/"+pythonClientGithubBranch+archiveSuffix
    else:
        archivePrefix=packageName
        urlPrefix = "https://files.pythonhosted.org/packages/d5/f9/4a8398c75e1b528b2dc42df27cd3e685539ac05c2e674ce14fb178abcfa3/"
        archiveSuffix = ".tar.gz"
        url = urlPrefix+archivePrefix+archiveSuffix
    
    installPackage(packageName, url, archivePrefix, archiveSuffix, path, moduleInstallationPrefix)
        
    # check that the installation worked
    addLocalSitePackageToPythonPath(moduleInstallationPrefix)
    import synapseclient
    
    # When trying to 'synStore' a table we get the error:
    # pandas.Styler requires jinja2. Please install with `conda install Jinja2`
    # So let's install Jinja2 here:
    # https://stackoverflow.com/questions/43163201/pyinstaller-syntax-error-yield-inside-async-function-python-3-5-1

    # Jinja2 depends on MarkupSafe
    packageName = "MarkupSafe-1.0"
    linkPrefix = "https://pypi.python.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/"
    installedPackageFolderName="markupsafe"
    simplePackageInstall(packageName, installedPackageFolderName, linkPrefix, path, localSitePackages)
    addLocalSitePackageToPythonPath(moduleInstallationPrefix)
    #import markupsafe  # This fails intermittently

    packageName = "Jinja2-2.8.1"
    linkPrefix = "https://pypi.python.org/packages/5f/bd/5815d4d925a2b8cbbb4b4960f018441b0c65f24ba29f3bdcfb3c8218a307/"
    installedPackageFolderName="jinja2"
    simplePackageInstall(packageName, installedPackageFolderName, linkPrefix, path, localSitePackages)
    addLocalSitePackageToPythonPath(moduleInstallationPrefix)
    #import jinja2 # This fails intermittently

# pip installs in the wrong place (ends up being in the PythonEmbedInR package rather than this one)
def call_pip(packageName, target):
        rc = pip.main(['install', packageName,  '--upgrade', '--quiet', '--target', target])
        if rc!=0:
            raise Exception('pip.main returned '+str(rc))

    
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
    shutil.move(packageDir+os.sep+installedPackageFolderName, localSitePackages)
        
    os.chdir(path)
    shutil.rmtree(packageDir)
    
    sys.path.append(localSitePackages+os.sep+installedPackageFolderName)

def installPackage(packageName, url, archivePrefix, archiveSuffix, path, moduleInstallationPrefix, redirectOutput=True):
    # download 
    zipFileName = archivePrefix + archiveSuffix
    localZipFile = path+os.sep+zipFileName
    x = urllib.request.urlopen(url)
    saveFile = open(localZipFile,'wb')
    saveFile.write(x.read())
    saveFile.close()
    
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
        if redirectOutput:
            stdouterrCapture(lambda: importlib.import_module("setup"), abbreviateStackTrace=False)
        else:
            importlib.import_module("setup")
    finally:
        sys.path=orig_sys_path
        sys.argv=orig_sys_argv
        # leave the folder we're about to delete
        os.chdir(path)
        shutil.rmtree(packageDir)

