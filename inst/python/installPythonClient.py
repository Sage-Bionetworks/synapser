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
import distutils.log
import platform
from setuptools.command.install import install
import tempfile
import time
import importlib

def main(path):
    print("At the entry point of installPythonclient.main()")
#     # PYTHONPATH sets the search path for importing python modules
#     if 'PYTHONPATH' in os.environ:
#         #print('PYTHONPATH: '+os.environ['PYTHONPATH'])
#         orig_python_path = os.environ['PYTHONPATH']
#     else:
#         #print('No PYTHONPATH env variable')
#         orig_python_path = None
#     
#     # this doesn't seem to help!
#     moduleInstallationFolder=path+os.sep+"inst"+os.sep+"python-packages"
#     
#     sys.path.insert(0, moduleInstallationFolder)
#     os.environ['PYTHONPATH'] = moduleInstallationFolder
    

#     # The preferred approach is to use pip...
#     call_pip('pip')
#     call_pip('urllib3')
#     call_pip('requests')
#     call_pip('six')
#     call_pip('backports.csv')
    
    # ...but - for some reason - pip breaks when we install future and the python synapse client
    
#     packageName = "future-0.15.2"
#     linkPrefix = "https://pypi.python.org/packages/5a/f4/99abde815842bc6e97d5a7806ad51236630da14ca2f3b1fce94c0bb94d3d/"
#     installPackage(packageName, linkPrefix, path)
#     
    packageName = "synapseclient-1.7.1"
    linkPrefix = "https://pypi.python.org/packages/56/da/e489aad73886e6572737ccfe679b3a2bc9e68b05636d4ac30302d0dcf261/"
    installPackage(packageName, linkPrefix, path)
        
            
def installPackage(packageName, linkPrefix, path):
    # download 
    zipFileName = packageName + ".tar.gz"
    x = urllib.request.urlopen(linkPrefix+zipFileName)
    localZipFile = path+os.sep+zipFileName
    saveFile = open(localZipFile,'wb')
    saveFile.write(x.read())
    saveFile.close()
    
    print("Downloaded "+zipFileName)

    tar = tarfile.open(localZipFile)
    moduleInstallationFolder=path+os.sep+"inst"
    tar.extractall(path=moduleInstallationFolder)
    tar.close()
    os.remove(localZipFile)
    
    print("Un-tarred "+localZipFile)
    
    packageDir = moduleInstallationFolder+os.sep+packageName
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
    sys.argv = ['setup.py', 'install', '--quiet']
    
    print("Currently in  directory: " +os.getcwd()+"\nAbout to import setup from "+packageName);
    
    try:
        importlib.import_module("setup") 
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
 
        print("Removing "+packageDir)
        # leave the folder we're about to delete
        os.chdir(path)
        shutil.rmtree(packageDir)


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
        print("-------------This is the accumulated output of 'pip.main': -------------")
        with open(outfilepath, 'r') as f:
            print(f.read())
        print("------------- DONE -------------")



