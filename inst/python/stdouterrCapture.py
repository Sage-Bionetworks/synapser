import sys   
import os
import tempfile
import synapseclient


def stdouterrCapture(function):
    origStdout=sys.stdout
    origStderr=sys.stderr 
    outfile=tempfile.mkstemp()
    outfilehandle=outfile[0]
    outfilepath=outfile[1]
    outfilehandle = open(outfilepath, 'w', encoding="utf-8")
    sys.stdout = outfilehandle
    sys.stderr = outfilehandle
     
    try:
        return function()
    finally:
        sys.stdout=origStdout
        sys.stderr=origStderr
        try:
            outfilehandle.flush()
            outfilehandle.close()
        except:
            pass # nothing to do
        with open(outfilepath, 'r') as f:
            print(f.read())
                    