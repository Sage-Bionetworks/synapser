import inspect
print ("idk wtf is going on")
import future
print ("futur IS HERE:" + future.__file__)
import synapseclient
print("imported synapse")

def functionInfo():
    result = []
    for member in inspect.getmembers(synapseclient.Synapse):
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
    print ("returned result")
    return result
