import inspect
import sys
from typing import Protocol

def is_method_from_protocol(method_func, class_definition) -> bool:
    """
    Check if a method comes from a Protocol class or mixin by examining the MRO
    and looking for classes that define this method and are part of the
    synapseclient protocol/mixin system.
    """
    if Protocol is None:
        return False

    method_name = method_func.__name__

    for base_class in class_definition.__mro__:
        if base_class is class_definition or base_class is object:
            continue

        if (issubclass(base_class, Protocol) and
                method_name in base_class.__dict__ and
                callable(getattr(base_class, method_name, None))):
            return True

    return False


def is_function_or_routine(member):
    """Check if a member is a function or routine.

    Args:
        member: The function or routine to check.

    Returns:
        True if the member is a function or routine, False otherwise.
    """
    return inspect.isfunction(member) or inspect.isroutine(member)


def argspec_content(fn):
    """Get the argument specification for a function.

    Args:
        fn: The function to get the argument specification for.

    Returns:
        A dictionary containing the argument specification.
    """
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


def _is_synapse_model_member(member):
    """Check if a function/method is a member of the synapseclient.models module.

    Args:
        member: The function/method to extract a docstring from.

    Returns:
        True if the member is a member of the synapseclient.models module, False otherwise.
    """
    return (hasattr(member, '__module__') and
            'synapseclient.models' in member.__module__)


def _resolve_owner_class(func, class_context):
    """
    Determine the class that owns `func`, used to seed a Protocol search. 
    If the class_context is not provided, the class that owns the function is returned.

    Tries four strategies in priority order:
      1. caller-supplied class_context — always pass this when known; async_to_sync
         wrappers have a __qualname__ of the form
         "async_to_sync.<locals>.create_method.<locals>.newmethod" that encodes no
         class name, so strategies 2–3 will fail and strategy 4 (full sys.modules
         scan) kicks in for every method unless class_context short-circuits it.
      2. bound method's __self__.__class__
      3. parse __qualname__ and look up the class in its own module
      4. scan synapseclient.models modules for any class that has the method
    """
    if class_context is not None:
        return class_context

    if hasattr(func, '__self__') and func.__self__ is not None:
        return func.__self__.__class__

    if hasattr(func, '__qualname__') and '.' in func.__qualname__:
        class_name = func.__qualname__.split('.')[0]
        module = sys.modules.get(getattr(func, '__module__', ''), None)
        if module:
            candidate = getattr(module, class_name, None)
            if inspect.isclass(candidate):
                return candidate

    func_name = getattr(func, '__name__', '')
    for module_name, module in sys.modules.items():
        if not (module and 'synapseclient.models' in module_name):
            continue
        for attr in module.__dict__.values():
            if (inspect.isclass(attr) and
                    hasattr(attr, func_name) and
                    callable(getattr(attr, func_name))):
                return attr

    return None


def _find_protocol_doc_in_mro(cls, method_name):
    """
    Walk the MRO of `cls` and return the first docstring found on a Protocol
    base class that defines `method_name`. Returns None if not found.
    """
    for base in cls.__mro__:
        if base is cls or base is object:
            continue
        try:
            is_proto = issubclass(base, Protocol)
        except TypeError:
            continue
        if (is_proto and
                method_name in base.__dict__ and
                callable(getattr(base, method_name, None))):
            doc = inspect.getdoc(getattr(base, method_name))
            if doc:
                return doc
    return None


def _find_protocol_docstring(func, class_context):
    """
    Return the Protocol-sourced docstring for a member.

    Searches the owner class's MRO first (fast path). The slow fallback —
    scanning all loaded modules — is only reached when the owner class cannot
    be resolved at all; if the class was found but has no Protocol doc for this
    method, the method simply isn't Protocol-defined and None is returned early.
    """
    func_name = getattr(func, '__name__', '')
    owner_class = _resolve_owner_class(func, class_context)

    if owner_class is not None:
        return _find_protocol_doc_in_mro(owner_class, func_name)

    for module in sys.modules.values():
        if not (module and hasattr(module, '__dict__')):
            continue
        for attr in module.__dict__.values():
            if not inspect.isclass(attr) or attr is Protocol:
                continue
            try:
                is_proto = issubclass(attr, Protocol)
            except TypeError:
                continue
            if (is_proto and
                    hasattr(attr, func_name) and
                    callable(getattr(attr, func_name))):
                doc = inspect.getdoc(getattr(attr, func_name))
                if doc:
                    return doc

    return None


def get_cleaned_doc(member, class_context=None):
    """
    Return the cleaned docstring for a member.

    For non-model members the member's own docstring is returned directly.
    For synapseclient.models members, the Protocol class docstring is preferred
    (it is the authoritative source for generated sync wrappers); the member's
    own docstring is used as a fallback when no Protocol doc is found.

    Args:
        member: The function/method to extract a docstring from.
        class_context: The class that owns the member. Passing this avoids an
            expensive module scan when looking up the Protocol hierarchy.
    """
    if not _is_synapse_model_member(member):
        doc = inspect.getdoc(member)
        return inspect.cleandoc(doc) if doc else None

    if not inspect.isclass(member):
        protocol_doc = _find_protocol_docstring(member, class_context)
        if protocol_doc:
            return inspect.cleandoc(protocol_doc)

    doc = inspect.getdoc(member)
    return inspect.cleandoc(doc) if doc else None

def method_attributes(name, method):
    """Collect the name, signature, docstring, and module for a single method.

    Args:
        name: The method name as it appears on the class.
        method: The callable to inspect.

    Returns:
        A dict with keys ``name``, ``args``, ``doc``, and ``module``.
    """
    args = argspec_content(method)
    cleaneddoc = get_cleaned_doc(method)
    return ({'name': name, 'args': args, 'doc': cleaneddoc,
             'module': method.__module__})

def getFunctionInfo(module):
    """Get the function information for a module.

    Args:
        module: The module to get the function information for.

    Returns:
        A list of dictionaries containing the function information.
    """
    result = []
    for member in inspect.getmembers(module, is_function_or_routine):
        name = member[0]
        if name.startswith("_"):
            continue
        method = member[1]
        result.append(method_attributes(name, method))
    return result


def getEnumInfo(module):
    """Get the enum information for a module.

    Args:
        module: The module to get the enum information for.

    Returns:
        A list of dictionaries containing the enum information.
    """
    import ast

    result = []
    for member in inspect.getmembers(module, inspect.isclass):
        name = member[0]
        classdefinition = member[1]
        if (name != "Enum" and
                (str(type(classdefinition)) == "<class 'enum.EnumMeta'>" or
                 str(type(classdefinition)) == "<class 'enum.EnumType'>")):

            enumValues = inspect.getmembers(classdefinition)
            enumValues = [item for item in enumValues if (
                not item[0].startswith('_') and
                item[0] not in ['name', 'value'])]
            keys = [x[0] for x in enumValues]
            values = [x[1] for x in enumValues]

            attribute_docs = {}
            if hasattr(module, '__file__') and module.__file__:
                with open(module.__file__, 'r') as f:
                    source = f.read()

                tree = ast.parse(source)

                for node in ast.walk(tree):
                    if isinstance(node, ast.ClassDef) and node.name == name:
                        for i, item in enumerate(node.body):
                            if isinstance(item, ast.Assign):
                                for target in item.targets:
                                    if isinstance(target, ast.Name):
                                        attr_name = target.id

                                        next_idx = i + 1
                                        has_docstring = (
                                            next_idx < len(node.body) and
                                            isinstance(node.body[next_idx],
                                                       ast.Expr) and
                                            isinstance(
                                                node.body[next_idx].value,
                                                ast.Constant) and
                                            isinstance(
                                                node.body[next_idx]
                                                .value.value, str))

                                        if has_docstring:
                                            next_node = node.body[next_idx]
                                            docstring = next_node.value.value
                                            attribute_docs[attr_name] = (
                                                inspect.cleandoc(docstring))
                        break

            enum_result = {
                'name': name,
                'keys': keys,
                'values': values
            }

            if attribute_docs:
                enum_result['attribute_docs'] = attribute_docs

            result.append(enum_result)
    return result


def getClassInfo(module):
    """Get the class information for a module.

    Args:
        module: The module to get the class information for.

    Returns:
        A list of dictionaries containing the class information.
    """
    result = []
    for member in inspect.getmembers(module, inspect.isclass):
        name = member[0]
        classdefinition = member[1]
        constructorArgs = None
        methods = []
        for classmember in inspect.getmembers(classdefinition,
                                              inspect.isfunction):
            methodName = classmember[0]
            if methodName == '__init__':
                constructorArgs = argspec_content(classmember[1])
            elif (not methodName.startswith("_")) and (
                classmember[1].__module__ == classdefinition.__module__ or
                is_method_from_protocol(classmember[1], classdefinition)
            ):
                if is_async_to_sync_wrapper(methodName, classdefinition):
                    protocol_args, protocol_doc = find_protocol_method_info(
                        methodName, classdefinition)
                    if protocol_args is not None and protocol_doc is not None:
                        methodArgs = protocol_args
                        methodDescription = protocol_doc
                    else:
                        methodArgs = argspec_content(classmember[1])
                        methodDescription = get_cleaned_doc(
                            classmember[1], class_context=classdefinition)
                else:
                    methodArgs = argspec_content(classmember[1])
                    methodDescription = get_cleaned_doc(
                        classmember[1], class_context=classdefinition)

                is_static = _is_static_in_mro(methodName, classdefinition)
                if is_static:
                    # Get the signature from the raw @staticmethod descriptor,
                    # bypassing any async_to_sync (*args, **kwargs) wrapper.
                    static_fn = _get_static_method_func(methodName, classdefinition)
                    if static_fn is not None:
                        methodArgs = argspec_content(static_fn)
                methods.append({'name': methodName,
                                'doc': methodDescription,
                                'args': methodArgs,
                                'is_static': is_static})
        if constructorArgs is None:
            continue
        cleaneddoc = get_cleaned_doc(classdefinition)
        methods.insert(
            0, {'name': name, 'doc': cleaneddoc, 'args': constructorArgs})
        result.append({'name': name, 'constructorArgs': constructorArgs,
                      'doc': cleaneddoc, 'methods': methods})
    return result


def is_async_to_sync_wrapper(method_name, class_definition):
    """A method is an async_to_sync wrapper if the class defines a
    coroutine method named {method_name}_async (see async_to_sync)."""
    async_sibling = inspect.getattr_static(
        class_definition, method_name + "_async", None)
    return inspect.iscoroutinefunction(async_sibling)

def _is_static_in_mro(method_name, class_definition):
    """Check if a method is declared as @staticmethod anywhere in the MRO.

    async_to_sync replaces @staticmethod descriptors with ClassOrInstance
    wrappers, so a direct inspect.getattr_static check on the class is not
    sufficient — we need to walk the full MRO.
    """
    for cls in class_definition.__mro__:
        raw = inspect.getattr_static(cls, method_name, None)
        if isinstance(raw, staticmethod):
            return True
    return False


def _get_static_method_func(method_name, class_definition):
    """Return the underlying function from the first @staticmethod in the MRO.

    This lets argspecContent read the real signature rather than the
    (*args, **kwargs) wrapper that async_to_sync generates.
    """
    for cls in class_definition.__mro__:
        raw = inspect.getattr_static(cls, method_name, None)
        if isinstance(raw, staticmethod):
            return raw.__func__
    return None


def find_protocol_method_info(method_name, class_definition):
    """
    Find the protocol method information for a given method name in the
    class hierarchy.
    Returns a tuple of (args_info, docstring) or (None, None) if not found.
    """
    if Protocol is None:
        return None, None

    for base_class in class_definition.__mro__:
        if base_class is class_definition or base_class is object:
            continue

        is_protocol_class = issubclass(base_class, Protocol)

        if is_protocol_class:
            if (method_name in base_class.__dict__ and
                    callable(getattr(base_class, method_name, None))):
                protocol_method = getattr(base_class, method_name)
                protocol_doc = inspect.getdoc(protocol_method)

                if protocol_doc:
                    protocol_args = argspec_content(protocol_method)
                    return protocol_args, protocol_doc

    return None, None
