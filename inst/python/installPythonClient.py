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
    
    moduleInstallationFolder=path+os.sep+"inst"
    sys.path.insert(0, moduleInstallationFolder)
    # The preferred approach is to use pip...
    
    call_pip(['install', 'pip',  '--upgrade', '--quiet'])
    call_pip(['install', '--user', 'urllib3',  '--upgrade', '--quiet'])
    call_pip(['install', '--user', 'requests',  '--upgrade', '--quiet'])
    call_pip(['install', '--user', 'six',  '--upgrade', '--quiet'])
    call_pip(['install', '--user', 'backports.csv',  '--upgrade', '--quiet'])
    
    # ...but - for some reason - pip breaks when we install future and the python synapse client
    # my guess is that pip 'shells out' to call setup.py and hops to another version of
    # python on the machine

    
    #pip.main(['install', '--user', 'future',  '--upgrade'])
    packageName = "future-0.15.2"
    linkPrefix = "https://pypi.python.org/packages/5a/f4/99abde815842bc6e97d5a7806ad51236630da14ca2f3b1fce94c0bb94d3d/"
    installPackage(packageName, linkPrefix, path)

    #pip.main(['install', '--user', 'synapseclient',  '--upgrade'])
    packageName = "synapseclient-1.6.1"
    linkPrefix = "https://pypi.python.org/packages/37/fd/5672e85abc68f4323e19e470cb7eeb0f8dc610566f124c930c3026404fb9/"
    installPackage(packageName, linkPrefix, path)
            
def installPackage(packageName, linkPrefix, path):
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
            distutils.core.run_setup(script_name='setup.py', script_args=['install', '--user', '--upgrade', '--quiet'])
            # step back one level before remove the directory
            os.chdir(path)
            shutil.rmtree(packageDir)
        else:
            os.chdir(path)
            call_pip(['install', '--user', localZipFile,  '--upgrade', '--quiet'])
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
            
def call_pip(args):
    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w')
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
    
    try:
        rc = pip.main(args)
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



