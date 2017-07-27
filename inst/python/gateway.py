import sys   
import os
import tempfile
import synapseclient


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
            raise Exception(str(exceptionToRaise))
        else:
            raise exceptionToRaise

# args[0] is an object and args[1] is a method name.  args[2:] are the method's arguments
def invoke(*args, **kwargs):
    print("In Python 'invoke'. 'args': "+str(args))
    print("In Python 'invoke'. 'kwargs': ")
    for key in kwargs.keys():
        print("\tkey: "+key+" value: "+str(kwargs[key]))
    
    method_to_call = getattr(args[0], args[1])
    return stdouterrCapture(lambda: method_to_call(*args[2:], **kwargs))

                    