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


def isFunctionOrRoutine(member):
    return inspect.isfunction(member) or inspect.isroutine(member)


def argspecContent(fn):
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


def getCleanedDoc(member, class_context=None):
    """
    Extract and clean docstrings from a member, collecting all docstrings
    found at any level of wrapped functions.

    Args:
        member: The function/method to extract docstring from
        class_context: The class that the member belongs to (if applicable)
    """

    if (hasattr(member, '__module__') and
            'synapseclient.models' not in member.__module__):
        doc = inspect.getdoc(member)
        if doc:
            return inspect.cleandoc(doc)

    all_docstrings = []

    def _find_protocol_method_docstring(func):
        """Find the docstring from the Protocol class."""
        func_name = getattr(func, '__name__', '')

        target_class = None

        if class_context is not None:
            target_class = class_context

        elif hasattr(func, '__self__') and func.__self__ is not None:
            target_class = func.__self__.__class__

        elif hasattr(func, '__qualname__') and '.' in func.__qualname__:
            parts = func.__qualname__.split('.')
            if len(parts) >= 2:
                class_name = parts[0]

                if hasattr(func, '__module__'):
                    module = sys.modules.get(func.__module__)
                    if module and hasattr(module, class_name):
                        potential_class = getattr(module, class_name)
                        if inspect.isclass(potential_class):
                            target_class = potential_class

        if target_class is None and hasattr(func, '__module__'):
            for module_name, module in sys.modules.items():
                if (module and
                        'synapseclient.models' in module_name and
                        hasattr(module, '__dict__')):
                    for attr_name, attr_value in module.__dict__.items():
                        if (inspect.isclass(attr_value) and
                                hasattr(attr_value, func_name) and
                                callable(getattr(attr_value, func_name))):
                            target_class = attr_value
                            break
                if target_class:
                    break

        if target_class is None:
            return None

        def _search_protocol_in_class_hierarchy(cls, method_name,
                                                visited=None):
            """Recursively search for Protocol method docstring."""
            if visited is None:
                visited = set()

            if cls in visited:
                return None
            visited.add(cls)

            for base_class in cls.__mro__:
                if base_class is cls or base_class is object:
                    continue

                is_protocol_class = issubclass(base_class, Protocol)

                if is_protocol_class:
                    if (method_name in base_class.__dict__ and
                            callable(getattr(base_class, method_name, None))):
                        protocol_method = getattr(base_class, method_name)
                        protocol_doc = inspect.getdoc(protocol_method)
                        if protocol_doc:
                            return protocol_doc

                elif (hasattr(base_class, '__mro__') and
                      len(base_class.__mro__) > 2):
                    result = _search_protocol_in_class_hierarchy(
                        base_class, method_name, visited)
                    if result:
                        return result

            return None

        protocol_doc = _search_protocol_in_class_hierarchy(
            target_class, func_name)
        if protocol_doc:
            return protocol_doc

        for module_name, module in sys.modules.items():
            if module and hasattr(module, '__dict__'):
                for attr_name, attr_value in module.__dict__.items():
                    if (inspect.isclass(attr_value) and
                            Protocol and
                            attr_value is not Protocol):
                        if issubclass(attr_value, Protocol):
                            if (hasattr(attr_value, func_name) and
                                    callable(getattr(
                                        attr_value, func_name))):
                                protocol_method = getattr(
                                    attr_value, func_name)
                                protocol_doc = inspect.getdoc(
                                    protocol_method)
                                if protocol_doc:
                                    return protocol_doc

        return None

    async_marker = 'The new method that will replace the non-async method'
    if (hasattr(member, '__name__') and
            hasattr(member, '__module__') and
            ('async_to_sync' in str(type(member)) or
             (inspect.getdoc(member) and
              async_marker in inspect.getdoc(member)))):

        protocol_doc = _find_protocol_method_docstring(member)
        if protocol_doc and protocol_doc not in all_docstrings:
            all_docstrings.insert(0, protocol_doc)

    if not all_docstrings:
        if (hasattr(member, '__module__') and
                'synapseclient.models' in member.__module__):
            doc = inspect.getdoc(member)
            if doc:
                return inspect.cleandoc(doc)

        return None

    for doc in all_docstrings:
        if doc and async_marker not in doc:
            return inspect.cleandoc(doc)

    return inspect.cleandoc(all_docstrings[0])


def methodAttributes(name, method):
    args = argspecContent(method)
    cleaneddoc = getCleanedDoc(method)
    return ({'name': name, 'args': args, 'doc': cleaneddoc,
             'module': method.__module__})


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
                constructorArgs = argspecContent(classmember[1])
            elif (not methodName.startswith("_")) and (
                classmember[1].__module__ == classdefinition.__module__ or
                is_method_from_protocol(classmember[1], classdefinition)
            ):
                if is_async_to_sync_wrapper(classmember[1]):
                    protocol_args, protocol_doc = find_protocol_method_info(
                        methodName, classdefinition)
                    if protocol_args is not None and protocol_doc is not None:
                        methodArgs = protocol_args
                        methodDescription = protocol_doc
                    else:
                        methodArgs = argspecContent(classmember[1])
                        methodDescription = getCleanedDoc(
                            classmember[1], class_context=classdefinition)
                else:
                    methodArgs = argspecContent(classmember[1])
                    methodDescription = getCleanedDoc(
                        classmember[1], class_context=classdefinition)

                methods.append({'name': methodName,
                                'doc': methodDescription,
                                'args': methodArgs})
        if constructorArgs is None:
            continue
        cleaneddoc = getCleanedDoc(classdefinition)
        methods.insert(
            0, {'name': name, 'doc': cleaneddoc, 'args': constructorArgs})
        result.append({'name': name, 'constructorArgs': constructorArgs,
                      'doc': cleaneddoc, 'methods': methods})
    return result


def is_async_to_sync_wrapper(method_func):
    """
    Check if a method is an async_to_sync wrapper by examining its module,
    qualname, and docstring.
    """
    if (not hasattr(method_func, '__module__') or
            not hasattr(method_func, '__qualname__')):
        return False

    if 'synapseclient.core.async_utils' not in method_func.__module__:
        return False

    if 'async_to_sync' in method_func.__qualname__:
        return True

    doc = inspect.getdoc(method_func)
    if doc and 'The new method that will replace the non-async method' in doc:
        return True

    return False


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
            if (hasattr(base_class, '__module__') and
                    base_class.__module__ and
                    'mixins' in base_class.__module__):
                continue

            if (method_name in base_class.__dict__ and
                    callable(getattr(base_class, method_name, None))):
                protocol_method = getattr(base_class, method_name)
                protocol_doc = inspect.getdoc(protocol_method)

                if (protocol_doc and
                        ('The new method that will replace the ' +
                         'non-async method') not in protocol_doc):
                    protocol_args = argspecContent(protocol_method)
                    return protocol_args, protocol_doc

    return None, None
