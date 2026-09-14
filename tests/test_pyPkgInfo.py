"""Unit tests for inst/python/pyPkgInfo.py"""

import inspect
import os
import sys
import types
from typing import Dict, List, Optional, Union

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "../inst/python"))

from pyPkgInfo import (
    _format_annotation,
    _is_classmethod_in_mro,
    _is_static_in_mro,
    argspec_content,
    get_cleaned_doc,
    getClassInfo,
    getFunctionInfo,
    is_async_to_sync_wrapper,
    method_attributes,
)

class dummy_class:
    """A dummy class used to test type-annotation formatting."""


class legacy_synapse_class:
    """Legacy Synapse class."""

    def __init__(self, x: int, y: int = 0):
        """Init SimpleClass."""
        self.x = x

    def public_method(self, a: str):
        """A public method."""
        return a

    def _private_method(self):
        pass

    @staticmethod
    def static_method(self, c: int):
        """Static method."""
        return c + 1


class synapse_model_class:
    """Synapse model class."""

    def __init__(self):
        pass

    async def get_async(self, a: str):
        """Async get function."""

    def get(self, a):
        """Sync wrapper for get_async method."""

    @staticmethod
    def static_method(c: int, d: int):
        """Static method."""
        return c + d


class synapse_model_class_with_static_async:
    """Synapse model class with a @staticmethod async method (mirrors QueryMixin.query_async)."""

    def __init__(self):
        pass

    @staticmethod
    async def query_async(query, limit=None):
        """Async static query method."""

    def query(self, query, limit=None):
        """Sync wrapper for query_async."""


class synapse_model_class_with_classmethod_async:
    """Synapse model class with a @classmethod async method"""

    def __init__(self):
        pass

    @classmethod
    async def from_parent_async(cls, parent):
        """Async classmethod get function."""

    def from_parent(self, parent):
        """Sync wrapper for from_parent_async."""


def unwrap_traced_method_test_helper(func):
    """Mimic the wrapper shape produced by
    ``synapseclient.core.async_utils.otel_trace_method`` — same wrapper name,
    same ``func`` free variable, no ``functools.wraps`` — without importing
    synapseclient, so the pyPkgInfo-side unwrap logic can be tested in
    isolation."""

    async def otel_trace_method_wrapper(self, *arg, **kwargs):
        """Wrapper for the function to be traced."""
        return await func(self, *arg, **kwargs)

    return otel_trace_method_wrapper


# ===========================================================================
# argspec_content
# ===========================================================================


class TestArgspecContent:
    def test_no_args(self):
        def fn():
            pass

        assert argspec_content(fn) == {
            "args": [],
            "varargs": None,
            "keywords": None,
            "defaults": (),
            "types": {},
        }

    def test_positional_args_only(self):
        def fn(a, b, c):
            pass

        r = argspec_content(fn)
        assert r["args"] == ["a", "b", "c"]
        assert r["defaults"] == ()
        assert r["varargs"] is None
        assert r["keywords"] is None

    def test_mixed(self):
        def fn(a, b=2, *args, **kwargs):
            pass

        r = argspec_content(fn)
        assert r["args"] == ["a", "b"]
        assert r["defaults"] == (2,)
        assert r["varargs"] == "args"
        assert r["keywords"] == "kwargs"

    def test_varargs_not_in_args_list(self):
        def fn(a, *rest, **kw):
            pass

        r = argspec_content(fn)
        assert r["args"] == ["a"]
        assert r["varargs"] == "rest"
        assert r["keywords"] == "kw"
        assert r["defaults"] == ()

    def test_captures_type_annotations(self):
        def fn(a: str, b: Optional[dummy_class] = None, c=3):
            pass

        r = argspec_content(fn)
        assert r["types"] == {"a": "str", "b": "Optional[dummy_class]"}

    def test_unannotated_args_omitted_from_types(self):
        def fn(a, b: str):
            pass

        r = argspec_content(fn)
        assert r["types"] == {"b": "str"}

    def test_varargs_and_keywords_not_in_types(self):
        def fn(a: str, *rest: int, **kw: bool):
            pass

        r = argspec_content(fn)
        assert r["types"] == {"a": "str"}

    def test_unwraps_otel_traced_method(self):
        # Without unwrapping, this would report `["self"]`/varargs="arg"/
        # keywords="kwargs" — the trace wrapper's own generic signature —
        # instead of the real method's.
        async def copy_async(self, parent_id, update_existing=False):
            """Copy the file."""

        r = argspec_content(unwrap_traced_method_test_helper(copy_async))
        assert r["args"] == ["self", "parent_id", "update_existing"]

    def test_wrapper_named_function_without_func_freevar_is_unaffected(self):
        def ordinary_function(x, y):
            """Not actually a trace wrapper."""
            return x + y

        r = argspec_content(ordinary_function)
        assert r["args"] == ["x", "y"]

# ===========================================================================
# _format_annotation
# ===========================================================================


class TestFormatAnnotation:
    def test_empty_annotation_returns_none(self):
        assert _format_annotation(inspect.Parameter.empty) is None

    def test_none_annotation_returns_none(self):
        assert _format_annotation(None) is None

    def test_builtin_type(self):
        assert _format_annotation(str) == "str"

    def test_custom_class_uses_short_name_not_qualified_path(self):
        # dummy_class.__module__ is this test module, not "builtins" — a naive
        # repr()/inspect.formatannotation() would produce the fully
        # qualified "test_pyPkgInfo.dummy_class" instead.
        assert _format_annotation(dummy_class) == "dummy_class"

    def test_optional(self):
        assert _format_annotation(Optional[str]) == "Optional[str]"

    def test_optional_of_custom_class(self):
        assert _format_annotation(Optional[dummy_class]) == "Optional[dummy_class]"

    def test_union_without_none(self):
        assert _format_annotation(Union[str, int]) == "Union[str, int]"

    def test_union_of_more_than_one_type_plus_none(self):
        # None is not a type, so it is wrapped in an Optional.
        assert (
            _format_annotation(Union[str, int, None])
            == "Optional[Union[str, int]]"
        )

    def test_list_of_str(self):
        assert _format_annotation(List[str]) == "list[str]"

    def test_dict_of_str_to_custom_class(self):
        assert _format_annotation(Dict[str, dummy_class]) == "dict[str, dummy_class]"


# ===========================================================================
# get_cleaned_doc
# ===========================================================================

class TestGetCleanedDoc:
    def test_with_docstring(self):
        def fn():
            """Simple docstring."""

        assert get_cleaned_doc(fn) == "Simple docstring."

    def test_without_docstring(self):
        def fn():
            pass

        assert get_cleaned_doc(fn) is None

    def test_multiline_docstring(self):
        def fn():
            """First line.

            Second paragraph.
            """

        doc = get_cleaned_doc(fn)
        assert doc == "First line.\n\nSecond paragraph."

    def test_indented_docstring_cleaned(self):
        def fn():
            """
            Indented content.
            More content.
            """

        doc = get_cleaned_doc(fn)
        assert doc == "Indented content.\nMore content."

    def test_unwraps_otel_traced_method(self):
        # Without unwrapping, this would return the trace wrapper's own
        # docstring, "Wrapper for the function to be traced.", instead of
        # the real method's.
        async def copy_async(self, parent_id):
            """Copy the file to another Synapse location."""

        assert (
            get_cleaned_doc(unwrap_traced_method_test_helper(copy_async))
            == "Copy the file to another Synapse location."
        )


# ===========================================================================
# method_attributes
# ===========================================================================


class TestMethodAttributes:
    def test_returns_method_metadata(self):
        def fn(a, b=2):
            """Docstring."""

        result = method_attributes("custom_name", fn)

        assert result == {
            "name": "custom_name",
            "args": {
                "args": ["a", "b"],
                "varargs": None,
                "keywords": None,
                "defaults": (2,),
                "types": {},
            },
            "doc": "Docstring.",
            "module": fn.__module__,
        }

    def test_doc_is_none_for_undocumented_method(self):
        def fn():
            pass

        result = method_attributes("custom_name", fn)
        assert result == {
            "name": "custom_name",
            "args": {
                "args": [],
                "varargs": None,
                "keywords": None,
                "defaults": (),
                "types": {},
            },
            "doc": None,
            "module": fn.__module__,
        }

    def test_includes_types_for_annotated_args(self):
        def fn(a: str, b: Optional[dummy_class] = None):
            """Docstring."""

        result = method_attributes("custom_name", fn)

        assert result == {
            "name": "custom_name",
            "args": {
                "args": ["a", "b"],
                "varargs": None,
                "keywords": None,
                "defaults": (None,),
                "types": {"a": "str", "b": "Optional[dummy_class]"},
            },
            "doc": "Docstring.",
            "module": fn.__module__,
        }


# ===========================================================================
# getFunctionInfo
# ===========================================================================


class TestGetFunctionInfo:
    @staticmethod
    def _module(**funcs):
        module = types.ModuleType("_test_module")
        for name, fn in funcs.items():
            setattr(module, name, fn)
        return module

    def test_empty_module(self):
        assert getFunctionInfo(types.ModuleType("_empty")) == []

    def test_returns_public_function_metadata(self):
        def fn(x):
            """Fn docstring."""

        assert getFunctionInfo(self._module(fn=fn)) == [
            {
                "name": "fn",
                "args": {
                    "args": ["x"],
                    "varargs": None,
                    "keywords": None,
                    "defaults": (),
                    "types": {},
                },
                "doc": "Fn docstring.",
                "module": fn.__module__,
            }
        ]

    def test_skips_private_functions(self):
        def _private():
            pass

        assert getFunctionInfo(self._module(_private=_private)) == []

    def test_only_public_returned_from_mixed_module(self):
        def fn_a():
            pass

        def fn_b():
            pass

        def _fn_c():
            pass

        result = getFunctionInfo(self._module(fn_a=fn_a, fn_b=fn_b, _fn_c=_fn_c))
        assert [r["name"] for r in result] == ["fn_a", "fn_b"]


# ===========================================================================
# getClassInfo
# ===========================================================================


class TestGetClassInfo:
    @staticmethod
    def _module_with_class(cls):
        module = types.ModuleType("_test_class_module")
        setattr(module, cls.__name__, cls)
        return module

    def test_class_without_explicit_init_excluded(self):
        class NoInit:
            """No init class."""

            def method(self):
                pass

        assert getClassInfo(self._module_with_class(NoInit)) == []

    def test_returns_class_metadata_for_public_methods(self):
        result = getClassInfo(self._module_with_class(legacy_synapse_class))

        assert result == [
            {
                "name": "legacy_synapse_class",
                "constructorArgs": {
                    "args": ["self", "x", "y"],
                    "varargs": None,
                    "keywords": None,
                    "defaults": (0,),
                    "types": {"x": "int", "y": "int"},
                },
                "doc": "Legacy Synapse class.",
                "methods": [
                    {
                        "name": "legacy_synapse_class",
                        "doc": "Legacy Synapse class.",
                        "args": {
                            "args": ["self", "x", "y"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (0,),
                            "types": {"x": "int", "y": "int"},
                        },
                    },
                    {
                        "name": "public_method",
                        "doc": "A public method.",
                        "args": {
                            "args": ["self", "a"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {"a": "str"},
                        },
                        "is_static": False,
                        "is_classmethod": False,
                    },
                    {
                        "name": "static_method",
                        "doc": "Static method.",
                        "args": {
                            "args": ["self", "c"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {"c": "int"},
                        },
                        "is_static": True,
                        "is_classmethod": False,
                    },
                ],
            }
        ]

    def test_marks_static_methods_and_async_wrappers(self):
        result = getClassInfo(self._module_with_class(synapse_model_class))

        assert result == [
            {
                "name": "synapse_model_class",
                "constructorArgs": {
                    "args": ["self"],
                    "varargs": None,
                    "keywords": None,
                    "defaults": (),
                    "types": {},
                },
                "doc": "Synapse model class.",
                "methods": [
                    {
                        "name": "synapse_model_class",
                        "doc": "Synapse model class.",
                        "args": {
                            "args": ["self"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {},
                        },
                    },
                    {
                        "name": "get",
                        "doc": "Async get function.",
                        "args": {
                            "args": ["self", "a"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {"a": "str"},
                        },
                        "is_static": False,
                        "is_classmethod": False,
                    },
                    {
                        "name": "get_async",
                        "doc": "Async get function.",
                        "args": {
                            "args": ["self", "a"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {"a": "str"},
                        },
                        "is_static": False,
                        "is_classmethod": False,
                    },
                    {
                        "name": "static_method",
                        "doc": "Static method.",
                        "args": {
                            "args": ["c", "d"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {"c": "int", "d": "int"},
                        },
                        "is_static": True,
                        "is_classmethod": False,
                    },
                ],
            }
        ]

    def test_marks_classmethods_and_async_wrappers(self):
        result = getClassInfo(
            self._module_with_class(synapse_model_class_with_classmethod_async)
        )

        assert result == [
            {
                "name": "synapse_model_class_with_classmethod_async",
                "constructorArgs": {
                    "args": ["self"],
                    "varargs": None,
                    "keywords": None,
                    "defaults": (),
                    "types": {},
                },
                "doc": "Synapse model class with a @classmethod async method",
                "methods": [
                    {
                        "name": "synapse_model_class_with_classmethod_async",
                        "doc": "Synapse model class with a @classmethod async method",
                        "args": {
                            "args": ["self"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {},
                        },
                    },
                    {
                        "name": "from_parent",
                        "doc": "Async classmethod get function.",
                        "args": {
                            "args": ["parent"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                            "types": {},
                        },
                        "is_static": False,
                        "is_classmethod": True,
                    },
                ],
            }
        ]

# ===========================================================================
# is_async_to_sync_wrapper
# ===========================================================================


class TestIsAsyncToSyncWrapper:
    def test_sync_with_async_sibling_is_wrapper(self):
        assert is_async_to_sync_wrapper("get", synapse_model_class)

    def test_regular_method_is_not_wrapper(self):
        assert not is_async_to_sync_wrapper("get_async", synapse_model_class)

    def test_nonexistent_method_returns_false(self):
        assert not is_async_to_sync_wrapper("nonexistent", synapse_model_class)

    def test_static_method_is_not_wrapper(self):
        assert not is_async_to_sync_wrapper("static_method", synapse_model_class)

    def test_static_async_sibling_is_wrapper(self):
        # query_async is declared @staticmethod async; is_async_to_sync_wrapper must
        # unwrap the staticmethod descriptor before checking iscoroutinefunction.
        assert is_async_to_sync_wrapper("query", synapse_model_class_with_static_async)

    def test_static_async_method_itself_is_not_wrapper(self):
        # query_async has no query_async_async sibling → not a wrapper
        assert not is_async_to_sync_wrapper(
            "query_async", synapse_model_class_with_static_async
        )

    def test_classmethod_async_sibling_is_wrapper(self):
        assert is_async_to_sync_wrapper(
            "from_parent", synapse_model_class_with_classmethod_async
        )

    def test_classmethod_async_method_itself_is_not_wrapper(self):
        # from_parent_async has no from_parent_async_async sibling → not a wrapper
        assert not is_async_to_sync_wrapper(
            "from_parent_async", synapse_model_class_with_classmethod_async
        )

# ===========================================================================
# _is_static_in_mro
# ===========================================================================


class TestIsStaticInMro:
    def test_staticmethod_returns_true(self):
        assert _is_static_in_mro("static_method", synapse_model_class)

    def test_instance_method_returns_false(self):
        assert not _is_static_in_mro("get", synapse_model_class)

    def test_nonexistent_method_returns_false(self):
        assert not _is_static_in_mro("nonexistent", synapse_model_class)

    def test_inherited_staticmethod_returns_true(self):
        class _Base:
            @staticmethod
            def inherited_static(x):
                return x

        class _Derived(_Base):
            def __init__(self):
                pass

            def own_method(self):
                pass

        assert _is_static_in_mro("inherited_static", _Derived)
        assert not _is_static_in_mro("own_method", _Derived)

# ===========================================================================
# _is_classmethod_in_mro
# ===========================================================================


class TestIsClassmethodInMro:
    def test_classmethod_returns_true(self):
        class _WithClassmethod:
            @classmethod
            def build(cls):
                return cls()

        assert _is_classmethod_in_mro("build", _WithClassmethod)

    def test_instance_method_returns_false(self):
        assert not _is_classmethod_in_mro("get", synapse_model_class)

    def test_staticmethod_returns_false(self):
        assert not _is_classmethod_in_mro("static_method", synapse_model_class)

    def test_nonexistent_method_returns_false(self):
        assert not _is_classmethod_in_mro("nonexistent", synapse_model_class)

