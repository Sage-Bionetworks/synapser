"""Unit tests for inst/python/pyPkgInfo.py"""

import inspect
import os
import sys
import types

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "../inst/python"))

from pyPkgInfo import (
    _get_static_method_func,
    _is_static_in_mro,
    argspec_content,
    get_cleaned_doc,
    getClassInfo,
    getFunctionInfo,
    is_async_to_sync_wrapper,
    method_attributes,
)


class legacy_synapse_class:
    """Legacy Synapse class."""

    def __init__(self, x, y=0):
        """Init SimpleClass."""
        self.x = x

    def public_method(self, a):
        """A public method."""
        return a

    def _private_method(self):
        pass

    @staticmethod
    def static_method(self, c):
        """Static method."""
        return c + 1


class synapse_model_class:
    """Synapse model class."""

    def __init__(self):
        pass

    async def get_async(self, a):
        """Async get function."""

    def get(self, a):
        """Sync wrapper for get_async method."""

    @staticmethod
    def static_method(c, d):
        """Static method."""
        return c + d


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
            },
            "doc": None,
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
                        },
                        "is_static": False,
                    },
                    {
                        "name": "static_method",
                        "doc": "Static method.",
                        "args": {
                            "args": ["self", "c"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                        },
                        "is_static": True,
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
                        },
                        "is_static": False,
                    },
                    {
                        "name": "get_async",
                        "doc": "Async get function.",
                        "args": {
                            "args": ["self", "a"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                        },
                        "is_static": False,
                    },
                    {
                        "name": "static_method",
                        "doc": "Static method.",
                        "args": {
                            "args": ["c", "d"],
                            "varargs": None,
                            "keywords": None,
                            "defaults": (),
                        },
                        "is_static": True,
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
# _get_static_method_func
# ===========================================================================


class TestGetStaticMethodFunc:
    def test_returns_callable_for_staticmethod(self):
        fn = _get_static_method_func("static_method", synapse_model_class)
        assert callable(fn)

    def test_returns_none_for_instance_method(self):
        assert not _is_static_in_mro("get", synapse_model_class)

    def test_inherited_staticmethod_resolved(self):
        class _Base:
            @staticmethod
            def inherited_static(x):
                return x

        class _Derived(_Base):
            def __init__(self):
                pass

            def own_method(self):
                pass

        fn = _get_static_method_func("inherited_static", _Derived)
        assert callable(fn)
        assert not _is_static_in_mro("own_method", _Derived)
