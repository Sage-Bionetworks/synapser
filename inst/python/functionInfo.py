import inspect
import synapseclient
import gateway

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
        classdefinition = member[1]
        # see https://docs.python.org/2/library/inspect.html
        
        # We need to get the arguments of the underlying __init__ method
        argspec=None
        for classmember in inspect.getmembers(classdefinition):
            if classmember[0]=='__init__':
                argspec = inspect.getargspec(classmember[1])
        if argspec is None:
            raise Exception("Cannot find constructor for "+name)
            
        args = {'args':argspec.args, 'varargs':argspec.varargs,
                'keywords':argspec.keywords, 'defaults':argspec.defaults}
        doc = inspect.getdoc(classdefinition)
        if doc is None:
            cleaneddoc = None
        else:
            cleaneddoc = inspect.cleandoc(doc)
        result.append({'name':name, 'args':args, 'doc':cleaneddoc})
    return result

