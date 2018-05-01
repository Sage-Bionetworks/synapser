
import synapseclient
import types
from stdouterrCapture import stdouterrCapture
from synapseclient.annotations import  Annotations

def annotationsModifier(a):
    # convert to a simple dictionary
    if isinstance(a, Annotations):
        return a.copy()
    else:
        return a

# args[0] is an object and args[1] is a method name.  args[2:] and kwargs are the method's arguments
def invoke(*args, **kwargs):
    method_to_call = getattr(args[0], args[1])
    return annotationsModifier(stdouterrCapture(lambda: method_to_call(*args[2:], **kwargs), abbreviateStackTrace=True))
