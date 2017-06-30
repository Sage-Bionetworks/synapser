import inspect
import synapseclient

def functionInfo():
    result = []
    for member in inspect.getmembers(synapseclient.Synapse):
        if len(member)<2:  # TODO remove
            print("functionInfo: expected len(member) to be at least 2 but was "+str(len(member)))
            continue
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
