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

def localSitePackageFolder(root):
    if os.name=='nt':
        # Windows
        return root+os.sep+"Lib"+os.sep+"site-packages"
    else:
        # Mac, Linux
        return root+os.sep+"lib"+os.sep+"python3.5"+os.sep+"site-packages"
    
def addLocalSitePackageToPythonPath(root):
    # PYTHONPATH sets the search path for importing python modules
    sitePackages = localSitePackageFolder(root)
    os.environ['PYTHONPATH'] = sitePackages
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
    # call_pip('pip') # (can even use pip to update pip itself)
    # ...but - for some reason - pip breaks when we install the python synapse client
    # So we use 'setup' directly
    packageName = "synapseclient-1.7.2"
    linkPrefix = "https://pypi.python.org/packages/67/30/9b1dd943be460368c1ab5babe17a9036425b97fd510451347c500966e56c/"
    installPackage(packageName, linkPrefix, path, moduleInstallationPrefix)
        
def call_pip(packageName):
    print("============== call_pip("+packageName+") ==============")
    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w', encoding="utf-8")
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
     
    try:
        rc = pip.main(['install', packageName,  '--upgrade', '--quiet'])
        if rc!=0:
            raise Exception('pip.main returned '+str(rc))
    finally:
        sys.stdout=origStdout
        sys.stderr=origStderr
        try:
            outfilehandle.flush()
            outfilehandle.close()
        except:
            pass # nothing to do
        print("-------------This is the accumulated output of 'pip.main' for package "+packageName+": -------------")
        with open(outfilepath, 'r') as f:
            print(f.read())
        print("------------- DONE -------------")

            
def installPackage(packageName, linkPrefix, path, moduleInstallationPrefix):
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

    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w', encoding="utf-8")
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
    
    orig_sys_path = sys.path
    orig_sys_argv = sys.argv
    sys.path = ['.'] + sys.path
    sys.argv = ['setup.py', 'install', '--prefix='+moduleInstallationPrefix]
        
    try:
        importlib.import_module("setup") 
        #import setup
        
    except SystemExit:
        print('caught SystemExit while setting up package '+packageName+'  sys.exc_info:'+repr(sys.exc_info()[1]))
        
    except Exception as e:
        print('caught Exception while setting up package '+packageNam+ ' '+str(e))
        
    finally:
        sys.path=orig_sys_path
        sys.argv=orig_sys_argv
        sys.stdout=origStdout
        sys.stderr=origStderr
        try:
            outfilehandle.flush()
            outfilehandle.close()
        except:
            pass # nothing to do
        with open(outfilepath, 'r') as f:
            print(f.read())
 
        # leave the folder we're about to delete
        os.chdir(path)
        shutil.rmtree(packageDir)


