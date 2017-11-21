import sys   
import os
import tempfile

EXCEPTION_MESSAGE_BOUNDARY='exception-message-boundary'

def stdouterrCapture(function, abbreviateStackTrace=True):
    origStdout=sys.stdout
    origStderr=sys.stderr 
    
    stdoutFilepath=tempfile.mkstemp()[1]
    stdoutFilehandle = open(stdoutFilepath, 'w', encoding="utf-8")
    sys.stdout = stdoutFilehandle
    
    stderrFilepath=tempfile.mkstemp()[1]
    stderrFilehandle = open(stderrFilepath, 'w', encoding="utf-8")
    sys.stderr = stderrFilehandle
     
    exceptionToRaise = None
    try:
        return function()
    except Exception as e:
        exceptionToRaise = e
    finally:
        sys.stdout=origStdout
        sys.stderr=origStderr
        try:
            stdoutFilehandle.flush()
            stderrFilehandle.flush()
            stdoutFilehandle.close()
            stderrFilehandle.close()
        except:
            pass # nothing to do
        with open(stdoutFilepath, 'r') as f:
            print(f.read())
        with open(stderrFilepath, 'r') as f:
            print(f.read())
            
    # We do this to suppress the automatic exception chaining that occurs when rethrowing
    # with an 'except' block
    if exceptionToRaise is not None:
        if abbreviateStackTrace:
            raise Exception(EXCEPTION_MESSAGE_BOUNDARY+str(exceptionToRaise)+EXCEPTION_MESSAGE_BOUNDARY)
        else:
            raise exceptionToRaise
       