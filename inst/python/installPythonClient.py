import sys

print("Here is the current module search path...")
for elem in sys.path:
    print(elem)
print("... the end.")
    
import pip
import os
import urllib
import gzip
import tarfile
import shutil
import distutils.core
import platform
from setuptools.command.install import install
import tempfile
import time

# install into <path>/inst/lib which will become the lib/ folder in the installed package
def main(path):
    
    # PYTHONPATH sets the search path for importing python modules
    if 'PYTHONPATH' in os.environ:
        print('PYTHONPATH: '+os.environ['PYTHONPATH'])
    else:
        print('No PYTHONPATH env variable')
    
    moduleInstallationFolder=path+os.sep+"inst"+os.sep+"python-packages"
    sys.path.insert(0, moduleInstallationFolder)
    # The preferred approach is to use pip...
    
    call_pip('pip', moduleInstallationFolder)
    call_pip('urllib3', moduleInstallationFolder)
    call_pip('requests', moduleInstallationFolder)
    call_pip('six', moduleInstallationFolder)
    call_pip('backports.csv', moduleInstallationFolder)
    
    # ...but - for some reason - pip breaks when we install future and the python synapse client
    # my guess is that pip 'shells out' to call setup.py and hops to another version of
    # python on the machine

    packageName = "future-0.15.2"
    linkPrefix = "https://pypi.python.org/packages/5a/f4/99abde815842bc6e97d5a7806ad51236630da14ca2f3b1fce94c0bb94d3d/"
    installPackage(packageName, linkPrefix, path, moduleInstallationFolder)

    packageName = "synapseclient-1.7.1"
    linkPrefix = "https://pypi.python.org/packages/56/da/e489aad73886e6572737ccfe679b3a2bc9e68b05636d4ac30302d0dcf261/"
    installPackage(packageName, linkPrefix, path, moduleInstallationFolder)
            
def installPackage(packageName, linkPrefix, path, moduleInstallationFolder):
    # download 
    zipFileName = packageName + ".tar.gz"
    x = urllib.request.urlopen(linkPrefix+zipFileName)
    localZipFile = path+os.sep+zipFileName
    saveFile = open(localZipFile,'wb')
    saveFile.write(x.read())
    saveFile.close()

    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w')
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
    
    try:
        if True:
            tar = tarfile.open(localZipFile)
            tar.extractall(path=path)
            tar.close()
            os.remove(localZipFile)
            
            packageDir = path+os.sep+packageName
            sys.path.append(packageDir)
            os.chdir(packageDir)
            
            sys.argv=['setup.py', 'install', '--user'] 
            # TODO how do we get 'setup.py' to install into inst/lib?
            distutils.core.run_setup(script_name='setup.py', script_args=['install', '--upgrade', '--quiet', '--target', moduleInstallationFolder])
            # step back one level before remove the directory
            os.chdir(path)
            shutil.rmtree(packageDir)
        else:
            os.chdir(path)
            call_pip(['install', localZipFile,  '--upgrade', '--quiet', '--target', moduleInstallationFolder])
            os.remove(localZipFile)
    finally:
        time.sleep(10)
        sys.stdout=origStdout
        sys.stderr=origStderr
        try:
            outfilehandle.flush()
            outfilehandle.close()
        except:
            pass # nothing to do
        print("-------------This is the accumulated output of 'run_setup': -------------")
        with open(outfilepath, 'r') as f:
            print(f.read())
        print("------------- DONE -------------")
        # The following causes an error: The process cannot access the file because it is being used by another process:
        # os we'll let the system remove the temp file
        # os.remove(outfilepath)
            
def call_pip(packageName, moduleInstallationFolder):
    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w')
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
    
    try:
        rc = pip.main(['install', packageName,  '--upgrade', '--quiet', '--target', moduleInstallationFolder])
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
        print("-------------This is the accumulated output of 'pip.main': -------------")
        with open(outfilepath, 'r') as f:
            print(f.read())
        print("------------- DONE -------------")



