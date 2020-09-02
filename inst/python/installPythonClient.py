import sys   
import pip
import os
import urllib.request
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
from patchStdoutStdErr import patch_stdout_stderr

def localSitePackageFolder(root):
    if os.name=='nt':
        # Windows
        return root+os.sep+"Lib"+os.sep+"site-packages"
    else:
        # Mac, Linux
        return root+os.sep+"lib"+os.sep+"python3.6"+os.sep+"site-packages"
    
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


def _find_python_interpreter():
    # helper heuristic to find the bundled python interpreter binary associated
    # with PythonEmbedInR. we need it in order to be able to invoke pip via
    # a subprocess. it's not in the same place because of how we build
    # PythonEmbedInR differently between the OSes.

    possible_interpreter_filenames = [
        'python',
        'python{}'.format(sys.version_info.major),
        'python{}.{}'.format(sys.version_info.major, sys.version_info.minor),
    ]
    possible_interpreter_filenames.extend(['{}.exe'.format(f) for f in possible_interpreter_filenames])
    possible_interpreter_filenames.extend([os.path.join('bin', f).format(f) for f in possible_interpreter_filenames])

    last_path = None
    path = inspect.getfile(os)
    while(path and path != last_path):
        for f in possible_interpreter_filenames:
            file_path = os.path.join(path, f)
            if os.path.isfile(file_path) and os.access(file_path, os.X_OK):
                return file_path

        last_path = path
        path = os.path.dirname(path)

    # if we didn't find anything we'll hope there is any 'python3' interpreter on the path.
    # we're just going to use it to install some modules into a specific directory
    # so it doesn't actually even have to be the one bundled with PythonEmbedInR
    return 'python{}'.format(sys.version_info.major)

PYTHON_INTERPRETER = _find_python_interpreter()

SYNAPSE_CLIENT_PACKAGE_NAME = 'synapseclient'
SYNAPSE_CLIENT_PACKAGE_VERSION = '2.2.0'

def main(path):
    patch_stdout_stderr()

    path = pkg_resources.normalize_path(path)
    moduleInstallationPrefix=path+os.sep+"inst"

    localSitePackages=localSitePackageFolder(moduleInstallationPrefix)

    addLocalSitePackageToPythonPath(moduleInstallationPrefix)

    os.makedirs(localSitePackages)

    # the least error prone way to install packages at runtime is by invoking
    # pip via a subprocess, although it's not straightforward to do so here.
    _install_pip([
        'pandas==0.22',

        # we install requests up front because it's a dependency of synapseclient anyway
        # but also comes with certifi which will give us some root CA certs which aren't
        # available otherwise on MacOS on python > 3.6 due to openssl changes
        # and which we'll need to exercise the branch build option below if since we
        # download via https.
        'requests>=2.22.0',
    ], localSitePackages)

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
        _install_pip(["synapseclient=={}".format(SYNAPSE_CLIENT_PACKAGE_VERSION)], localSitePackages)

    # check that the installation worked
    addLocalSitePackageToPythonPath(moduleInstallationPrefix)
    import synapseclient

    if platform.system() != 'Windows':
        # on linux and mac we can install these via a pip subprocess...
        _install_pip([
           "MarkupSafe==1.0",
           "Jinja2==2.8.1",
        ], localSitePackages)

    else:
        # ...but on windows installing via a subprocess breaks seemingly with the wheel install,
        # so we use the creative sideloading as below.

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

    addLocalSitePackageToPythonPath(moduleInstallationPrefix)


def _install_pip(packages, localSitePackages):
    # the recommended way to call pip at runtime is by invoking a subprocess,
    # but that's complicated by the fact that we don't know where the python
    # interpreter is. usually you can do sys.executable but in the embedded
    # context sys.executable is R, not python. So we do a heuristic to
    # find the interpreter. this seems to work better here than calling main
    # on pip directly which doesn't work for some of these packages (separately
    # from the other issues above...)
    for package in packages:
        rc = subprocess.call([PYTHON_INTERPRETER, "-m", "pip", "install", package, "--upgrade", "--quiet", "--target", localSitePackages])
        if rc != 0:
            raise Exception("pip.main returned {} when installing {}".format(rc, package))


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


def installPackage(packageName, url, archivePrefix, archiveSuffix, path, moduleInstallationPrefix):
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
        importlib.import_module("setup")
    finally:
        sys.path=orig_sys_path
        sys.argv=orig_sys_argv
        # leave the folder we're about to delete
        os.chdir(path)
        shutil.rmtree(packageDir)



