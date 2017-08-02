import sys   
import os
import tempfile
import synapseclient
import types


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
        
class GeneratorWrapper():
    def __init__(self, wrapped):
       object.__setattr__(self, 'inner', wrapped)

    def __getattr__(self, attr):
        return getattr(self.inner, attr)

    def __setattr__(self, attr, value):
        setattr(self.inner, attr, value)
    
    def nextElem(self):
        return self.__next__()

# from https://stackoverflow.com/questions/972/adding-a-method-to-an-existing-object-instance#2982
def generatorModifier(g):
    # add a public method to get the next value from a generator or iterator
    if isinstance(g, types.GeneratorType):
        return GeneratorWrapper(g)
    else:
        return g

# args[0] is an object and args[1] is a method name.  args[2:] and kwargs are the method's arguments
def invoke(*args, **kwargs):
    method_to_call = getattr(args[0], args[1])
    return generatorModifier(stdouterrCapture(lambda: method_to_call(*args[2:], **kwargs)))

                    