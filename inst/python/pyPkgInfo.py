import inspect
import sys
from typing import Protocol


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
        "args": args,
        "varargs": varargs,
        "keywords": keywords,
        "defaults": tuple(defaults),
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
        if name != "Enum" and (
            str(type(classdefinition)) == "<class 'enum.EnumMeta'>"
            or str(type(classdefinition)) == "<class 'enum.EnumType'>"
        ):

            enumValues = inspect.getmembers(classdefinition)
            enumValues = [
                item
                for item in enumValues
                if (not item[0].startswith("_") and item[0] not in ["name", "value"])
            ]
            keys = [x[0] for x in enumValues]
            values = [x[1] for x in enumValues]

            attribute_docs = {}
            if hasattr(module, "__file__") and module.__file__:
                with open(module.__file__, "r") as f:
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
                                            next_idx < len(node.body)
                                            and isinstance(
                                                node.body[next_idx], ast.Expr
                                            )
                                            and isinstance(
                                                node.body[next_idx].value, ast.Constant
                                            )
                                            and isinstance(
                                                node.body[next_idx].value.value, str
                                            )
                                        )

                                        if has_docstring:
                                            next_node = node.body[next_idx]
                                            docstring = next_node.value.value
                                            attribute_docs[attr_name] = (
                                                inspect.cleandoc(docstring)
                                            )
                        break

            enum_result = {"name": name, "keys": keys, "values": values}

            if attribute_docs:
                enum_result["attribute_docs"] = attribute_docs

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
        for classmember in inspect.getmembers(classdefinition, inspect.isfunction):
            methodName = classmember[0]
            if methodName == "__init__":
                constructorArgs = argspec_content(classmember[1])
            elif (not methodName.startswith("_")) and (
                classmember[1].__module__ == classdefinition.__module__
            ):
                if is_async_to_sync_wrapper(methodName, classdefinition):
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
                    methodArgs = argspec_content(classmember[1])
                    methodDescription = get_cleaned_doc(classmember[1])

                is_static = _is_static_in_mro(methodName, classdefinition)
                if is_static:
                    # Get the signature from the raw @staticmethod descriptor,
                    # bypassing any async_to_sync (*args, **kwargs) wrapper.
                    static_fn = _get_static_method_func(methodName, classdefinition)
                    if static_fn is not None:
                        methodArgs = argspec_content(static_fn)
                methods.append(
                    {
                        "name": methodName,
                        "doc": methodDescription,
                        "args": methodArgs,
                        "is_static": is_static,
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
    """Return the underlying function from the first @staticmethod in the MRO."""
    for cls in class_definition.__mro__:
        raw = inspect.getattr_static(cls, method_name, None)
        if isinstance(raw, staticmethod):
            return raw.__func__
    return None
