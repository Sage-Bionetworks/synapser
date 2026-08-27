import dataclasses
import inspect
import typing

def is_function_or_routine(member):
    """Check if a member is a function or routine.

    Args:
        member: The function or routine to check.

    Returns:
        True if the member is a function or routine, False otherwise.
    """
    return inspect.isfunction(member) or inspect.isroutine(member)


def _empty_default_for_annotation(annotation):
    """Resolve a real, empty container matching a type annotation's kind.

    When a dataclass field uses ``field(default_factory=...)``, Python
    doesn't store the factory's result as the default — it stores a
    ``_HAS_DEFAULT_FACTORY`` sentinel instead, and only calls the factory
    later, inside the generated ``__init__`` body. ``inspect.signature`` can
    only see that sentinel, so there's no way to introspect what the factory
    actually produces (e.g. ``list()`` vs. ``dict()``).

    To work around this, we look at the parameter's type annotation instead
    (``List[str]``, ``Dict[str, Column]``, ``Optional[List[str]]``, ...) and
    build a real, empty instance of the matching container kind. That way
    downstream consumers (e.g. the R doc generator) see an actual empty
    list/dict rather than the opaque, un-renderable sentinel object.

    Args:
        annotation: The parameter's type annotation to resolve a container
            kind from.

    Returns:
        A new empty ``list`` or ``dict``, or None if the annotation doesn't
        resolve to a known container type.
    """
    origin = typing.get_origin(annotation)
    if origin is typing.Union:
        for arg in typing.get_args(annotation):
            if arg is not type(None):
                resolved = _empty_default_for_annotation(arg)
                if resolved is not None:
                    return resolved
        return None
    if origin in (list, set, frozenset, tuple) or annotation in (
        list,
        set,
        frozenset,
        tuple,
    ):
        return []
    if origin is dict or annotation is dict:
        return {}
    return None


def _format_annotation(annotation):
    """Render a type annotation as a short, human-readable string.

    Used as a fallback when a Google-style docstring's ``Arguments:`` entry
    doesn't include a ``(type)`` annotation for that parameter.

    Prefers short names (``Synapse``, ``Optional[str]``) over the
    fully-qualified module paths that ``repr()``/``inspect.formatannotation``
    would otherwise produce (``synapseclient.client.Synapse``). Those long
    paths are hard to read inline in an R argument description, where a
    short type name reads more naturally.

    Args:
        annotation: The parameter's type annotation to render.

    Returns:
        A string representing the parameter's type annotation, or None if there's no real annotation to show.
    """
    if annotation is inspect.Parameter.empty or annotation is None:
        return None
    if isinstance(annotation, str):
        # already a string, e.g. under `from __future__ import annotations`
        return annotation

    origin = typing.get_origin(annotation)
    if origin is None:
        # For a bare type like `Synapse`, `int`, `str`, `float`, etc. which are not parameterized,
        # typing.get_origin(annotation) returns None, so we use the __qualname__ or str(annotation) to get the name.
        return getattr(annotation, "__qualname__", None) or str(annotation)

    args = typing.get_args(annotation)
    if origin is typing.Union:
        remaining = [a for a in args if a is not type(None)]
        if len(remaining) < len(args):
            # Optional[X] is represented as Union[X, None]
            if len(remaining) == 1:
                return f"Optional[{_format_annotation(remaining[0])}]"
            inner = ", ".join(_format_annotation(a) for a in remaining)
            return f"Optional[Union[{inner}]]"
        inner = ", ".join(_format_annotation(a) for a in args)
        return f"Union[{inner}]"
    # Most origins (list, dict, etc.) have a real __name__; a few typing
    # special forms don't, so fall back to str() and strip the "typing." prefix
    origin_name = getattr(origin, "__name__", None) or str(origin).replace(
        "typing.", ""
    )
    # plain types like `Synapse` or `int` 
    if not args:
        return origin_name
    # parameterized types like `List[str]` or `Dict[str, Column]` have parameters, so we join them with commas.
    inner = ", ".join(_format_annotation(a) for a in args)
    return f"{origin_name}[{inner}]"


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
    types = {}
    varargs = None
    keywords = None
    for name, param in fn_signature.parameters.items():
        if param.kind == inspect.Parameter.VAR_POSITIONAL:
            varargs = name
        elif param.kind == inspect.Parameter.VAR_KEYWORD:
            keywords = name
        else:
            args.append(name)
            formattedType = _format_annotation(param.annotation)
            if formattedType is not None:
                types[name] = formattedType
            if param.default != inspect.Signature.empty:
                default = param.default
                if isinstance(default, dataclasses._HAS_DEFAULT_FACTORY_CLASS):
                    resolved = _empty_default_for_annotation(param.annotation)
                    if resolved is not None:
                        default = resolved
                defaults.append(default)

    return {
        "args": args,
        "varargs": varargs,
        "keywords": keywords,
        "defaults": tuple(defaults),
        "types": types,
    }


def get_cleaned_doc(member):
    """Return the cleaned docstring for a member.

    Args:
        member: The function/method to extract a docstring from.
    """
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
    return {"name": name, "args": args, "doc": cleaneddoc, "module": method.__module__}


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

# TODO: to visit when working on https://sagebionetworks.jira.com/browse/SYNR-1550
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
        for classmember in inspect.getmembers(classdefinition, inspect.isfunction):
            methodName = classmember[0]
            if methodName == "__init__":
                constructorArgs = argspec_content(classmember[1])
            elif not methodName.startswith("_"):
                if is_async_to_sync_wrapper(methodName, classdefinition):
                    is_static = _is_static_in_mro(methodName + "_async", classdefinition)
                    is_classmethod = _is_classmethod_in_mro(
                        methodName + "_async", classdefinition
                    )
                    async_method = getattr(classdefinition, methodName + "_async", None)
                    if async_method is not None:
                        methodArgs = argspec_content(async_method)
                        methodDescription = inspect.cleandoc(
                            inspect.getdoc(async_method) or ""
                        )
                    else:
                        methodArgs = argspec_content(classmember[1])
                        methodDescription = get_cleaned_doc(classmember[1])
                else:
                    is_static = _is_static_in_mro(methodName, classdefinition)
                    is_classmethod = _is_classmethod_in_mro(methodName, classdefinition)
                    methodArgs = argspec_content(classmember[1])
                    methodDescription = get_cleaned_doc(classmember[1])
                methods.append(
                    {
                        "name": methodName,
                        "doc": methodDescription,
                        "args": methodArgs,
                        "is_static": is_static,
                        "is_classmethod": is_classmethod,
                    }
                )
        if constructorArgs is None:
            continue
        cleaneddoc = get_cleaned_doc(classdefinition)
        methods.insert(0, {"name": name, "doc": cleaneddoc, "args": constructorArgs})
        result.append(
            {
                "name": name,
                "constructorArgs": constructorArgs,
                "doc": cleaneddoc,
                "methods": methods,
            }
        )
    return result


def is_async_to_sync_wrapper(method_name, class_definition):
    """A method is an async_to_sync wrapper if the class defines a
    coroutine method named {method_name}_async."""
    async_sibling = inspect.getattr_static(
        class_definition, method_name + "_async", None
    )
    # if the async sibling is declared as @staticmethod or @classmethod, a
    # descriptor object is returned, not the underlying function -- unwrap it
    # so inspect.iscoroutinefunction can see the real coroutine function.
    if isinstance(async_sibling, (staticmethod, classmethod)):
        async_sibling = async_sibling.__func__
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


def _is_classmethod_in_mro(method_name, class_definition):
    """Check if a method is declared as @classmethod anywhere in the MRO.

    async_to_sync replaces @classmethod descriptors with ClassOrInstance
    wrappers, so a direct inspect.getattr_static check on the class is not
    sufficient — we need to walk the full MRO.
    """
    for cls in class_definition.__mro__:
        raw = inspect.getattr_static(cls, method_name, None)
        if isinstance(raw, classmethod):
            return True
    return False

