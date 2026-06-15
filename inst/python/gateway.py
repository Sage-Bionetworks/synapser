import types
from abbreviateStackTrace import abbreviateStackTrace
from patchStdoutStdErr import patch_stdout_stderr

# TODO: This class is might be redundant if using reticulate::iter_next() / reticulate::iterate()
class GeneratorWrapper:
    def __init__(self, wrapped):
        self._inner = wrapped
        self._use_list = False
        self._use_iter = False

    def nextElem(self):
        if self._use_list:
            raise Exception("Have already enumerated all elements.")
        self._use_iter = True
        return self._inner.__next__()

    def asList(self):
        if self._use_iter:
            raise Exception("Can't generate a list once enumeration has begun.")
        if self._use_list:
            raise Exception("Have already enumerated all elements.")
        self._use_list = True
        return list(self._inner)

# from https://stackoverflow.com/questions/972/adding-a-method-to-an-existing-object-instance#2982
def generatorModifier(g):
    # add a public method to get the next value from a generator or iterator
    if isinstance(g, types.GeneratorType):
        return GeneratorWrapper(g)
    else:
        return g


def _coerce_numeric(obj):
    """Recursively convert whole-number R doubles (e.g. 1.0) to Python ints.

    reticulate passes R numeric vectors as Python floats. Many Synapse API
    parameters (version_number, principal_id, …) expect int/Long. This avoids
    requiring callers to write 1L in R everywhere since R passes bare 1 to Python
    as a double (1.0), but the Synapse API expects a Long. 
    """
    if isinstance(obj, float) and obj.is_integer():
        return int(obj)
    if isinstance(obj, (list, tuple)):
        coerced = (_coerce_numeric(x) for x in obj)
        return type(obj)(coerced)
    if isinstance(obj, dict):
        return {k: _coerce_numeric(v) for k, v in obj.items()}
    return obj


# expects a dict with the keys: method (a list of [object, method name]), args, and kwargs
def invoke(**kwargs):
    patch_stdout_stderr()
    method = kwargs["method"]
    args = _coerce_numeric(kwargs["args"])
    kw = _coerce_numeric(dict(kwargs["kwargs"]))
    method_to_call = getattr(method[0], method[1])
    return generatorModifier(abbreviateStackTrace(lambda: method_to_call(*args, **kw)))
