import inspect
# import gateway

def isFunctionOrRoutine(member):
    return inspect.isfunction(member) or inspect.isroutine(member)

def argspecContent(fn):
    # follow_wrapped since we generally are not concerned about decorators
    fn_signature = inspect.signature(fn, follow_wrapped=True)

    args = []
    defaults = []
    varargs = None
    keywords = None
    for name, param in fn_signature.parameters.items():
        if param.kind == inspect.Parameter.VAR_POSITIONAL:
            varargs = name
        elif param.kind == inspect.Parameter.VAR_KEYWORD:
            keywords = name
        else:
            args.append(name)
            if param.default != inspect.Signature.empty:
                defaults.append(param.default)

    return {
        'args': args,
        'varargs': varargs,
        'keywords': keywords,
        'defaults': tuple(defaults),
    }

def getCleanedDoc(member):
    doc = inspect.getdoc(member)
    if doc is None:
        return None
    else:
        return inspect.cleandoc(doc)

def methodAttributes(name, method):
    args = argspecContent(method)
    cleaneddoc = getCleanedDoc(method)
    return({'name':name, 'args':args, 'doc':cleaneddoc, 'module':method.__module__})

def getFunctionInfo(module):
    result = []
    for member in inspect.getmembers(module, isFunctionOrRoutine):
        name = member[0]
        if name.startswith("_"):
            continue
        method = member[1]
        result.append(methodAttributes(name, method))
    return result

def getEnumInfo(module):
    result = []
    for member in inspect.getmembers(module, inspect.isclass):
        name = member[0]
        classdefinition = member[1]
        if name != "Enum" and str(type(classdefinition))=="<class 'enum.EnumMeta'>":
            enumValues = inspect.getmembers(classdefinition)
            enumValues = [item for item in enumValues if (not item[0].startswith('_') and item[0] not in ['name', 'value'])]
            keys = [x[0] for x in enumValues]
            values = [x[1] for x in enumValues]
            result.append({'name':name, 'keys':keys, 'values':values})
    return result

def getClassInfo(module):
    result = []
    for member in inspect.getmembers(module, inspect.isclass):
        name = member[0]
        classdefinition = member[1]
        constructorArgs=None
        methods = []
        # let's go through all the functions
        for classmember in inspect.getmembers(classdefinition, inspect.isfunction):
            methodName = classmember[0]
            if methodName=='__init__':
                constructorArgs = argspecContent(classmember[1])
            elif (not methodName.startswith("_")) and classmember[1].__module__==classdefinition.__module__:
                # this is a non-private, non-inherited function defined in the class
                methodArgs = argspecContent(classmember[1])
                methodDescription = getCleanedDoc(classmember[1])
                methods.append({'name':methodName, 'doc':methodDescription, 'args':methodArgs})
        if constructorArgs is None:
            continue
        cleaneddoc = getCleanedDoc(classdefinition)
        # insert the constructor itself as the first thing in the list
        methods.insert(0, {'name':name, 'doc':cleaneddoc, 'args':constructorArgs})
        result.append({'name':name, 'constructorArgs':constructorArgs, 'doc':cleaneddoc, 'methods':methods})
    return result

