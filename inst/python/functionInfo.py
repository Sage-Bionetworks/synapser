import inspect
import synapseclient
import stdouterrCapture

def isFunctionOrRoutine(member):
    return inspect.isfunction(member) or inspect.isroutine(member)

# return all the functions in the Synapse class
def functionInfo():
    result = []
    for member in inspect.getmembers(synapseclient.Synapse, isFunctionOrRoutine):
        name = member[0]
        if name.startswith("_"):
            continue
        method = member[1]
        # see https://docs.python.org/2/library/inspect.html
        argspec = inspect.getargspec(method)
        args = {'args':argspec.args, 'varargs':argspec.varargs,
                'keywords':argspec.keywords, 'defaults':argspec.defaults}
        doc = inspect.getdoc(method)
        if doc is None:
            cleaneddoc = None
        else:
            cleaneddoc = inspect.cleandoc(doc)
        result.append({'name':name, 'args':args, 'doc':cleaneddoc})
        
    return result

# list all the Classes in the synapseclient module
def constructorInfo():
    result = []
    for member in inspect.getmembers(synapseclient, inspect.isclass):
        name = member[0]
        if name=="Synapse":
            continue
        method = member[1]
        # see https://docs.python.org/2/library/inspect.html
        argspec = inspect.getargspec(method)
        args = {'args':argspec.args, 'varargs':argspec.varargs,
                'keywords':argspec.keywords, 'defaults':argspec.defaults}
        doc = inspect.getdoc(method)
        if doc is None:
            cleaneddoc = None
        else:
            cleaneddoc = inspect.cleandoc(doc)
        result.append({'name':name, 'args':args, 'doc':cleaneddoc})
    return result

# args[0] is an object and args[1] is a method name.  args[2:] are the method's arguments
def invokeWithStdouterrCapture(*args):
    method_to_call = getattr(args[0], args[1])
    return stdouterrCapture.stdouterrCapture(lambda: method_to_call(*args[2:]))
