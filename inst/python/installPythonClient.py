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
    
#    try:
        # The preferred approach is to use pip...
#         call_pip('pip', moduleInstallationFolder)
#         call_pip('urllib3', moduleInstallationFolder)
#         call_pip('requests', moduleInstallationFolder)
#         call_pip('six', moduleInstallationFolder)
#         call_pip('backports.csv', moduleInstallationFolder)
        
        # ...but - for some reason - pip breaks when we install future and the python synapse client
        # my guess is that pip 'shells out' to call setup.py and hops to another version of
        # python on the machine
    
#         packageName = "future-0.15.2"
#         linkPrefix = "https://pypi.python.org/packages/5a/f4/99abde815842bc6e97d5a7806ad51236630da14ca2f3b1fce94c0bb94d3d/"
#         installPackage(packageName, linkPrefix, path, moduleInstallationFolder)
    
    packageName = "synapseclient-1.7.1"
    linkPrefix = "https://pypi.python.org/packages/56/da/e489aad73886e6572737ccfe679b3a2bc9e68b05636d4ac30302d0dcf261/"
    installPackage(packageName, linkPrefix, path)
    
#    finally:
#        os.environ['PYTHONPATH'] = orig_python_path
        
            
def installPackage(packageName, linkPrefix, path):
    # download 
    zipFileName = packageName + ".tar.gz"
    x = urllib.request.urlopen(linkPrefix+zipFileName)
    localZipFile = path+os.sep+zipFileName
    saveFile = open(localZipFile,'wb')
    saveFile.write(x.read())
    saveFile.close()

    tar = tarfile.open(localZipFile)
    moduleInstallationFolder=path+os.sep+"inst"
    tar.extractall(path=moduleInstallationFolder)
    tar.close()
    os.remove(localZipFile)
    
    packageDir = moduleInstallationFolder+os.sep+packageName
    os.chdir(packageDir)

    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w')
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
    
    orig_sys_path = sys.path
    orig_sys_argv = sys.argv
    sys.path = ['.'] + sys.path
    sys.argv = ['setup.py', 'install'] # might also add --quiet
    
    try:
#         print("Current directory content:")
#         print(os.listdir())
        import setup       
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
#        print("-------------This is the accumulated output of 'run_setup': -------------")
        with open(outfilepath, 'r') as f:
            print(f.read())
 #       print("------------- DONE -------------")
        # The following causes an error: The process cannot access the file because it is being used by another process:
        # os we'll let the system remove the temp file
        # os.remove(outfilepath)

        # step back one level before removing the directory
        os.chdir(path)
        shutil.rmtree(packageDir)


# def call_pip(packageName, moduleInstallationFolder):
#     origStdout=sys.stdout
#     origStderr=sys.stderr 
#     outfile=tempfile.mkstemp()
#     outfilehandle=outfile[0]
#     outfilepath=outfile[1]
#     outfilehandle = open(outfilepath, 'w')
#     sys.stdout = outfilehandle
#     sys.stderr = outfilehandle
#     
#     try:
#         rc = pip.main(['install', packageName,  '--upgrade', '--quiet', '--target', moduleInstallationFolder])
#         if rc!=0:
#             raise Exception('pip.main returned '+str(rc))
#     finally:
#         sys.stdout=origStdout
#         sys.stderr=origStderr
#         try:
#             outfilehandle.flush()
#             outfilehandle.close()
#         except:
#             pass # nothing to do
#         print("-------------This is the accumulated output of 'pip.main': -------------")
#         with open(outfilepath, 'r') as f:
#             print(f.read())
#         print("------------- DONE -------------")



