
import synapseclient
import types
from stdouterrCapture import stdouterrCapture
from synapseclient.annotations import  Annotations
 
class GeneratorWrapper():
    def __init__(self, wrapped):
       self._inner = wrapped
       self._list = list(self._inner)

    def asList(self):
        return self._list

# from https://stackoverflow.com/questions/972/adding-a-method-to-an-existing-object-instance#2982
def generatorModifier(g):
    # add a public method to get the next value from a generator or iterator
    if isinstance(g, types.GeneratorType):
        return GeneratorWrapper(g)
    else:
        return g
    
def annotationsModifier(a):
    # convert to a simple dictionary
    if isinstance(a, Annotations):
        return a.copy()
    else:
        return a


# args[0] is an object and args[1] is a method name.  args[2:] and kwargs are the method's arguments
def invoke(*args, **kwargs):
    method_to_call = getattr(args[0], args[1])
    return annotationsModifier(generatorModifier(stdouterrCapture(lambda: method_to_call(*args[2:], **kwargs), abbreviateStackTrace=True)))
                
