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


def invoke(**kwargs):
    """Invoke a Python method from R via the reticulate bridge.

    Expects kwargs with keys:
      - method: a (object, method_name) tuple identifying the callable
      - args: positional arguments
      - kwargs: keyword arguments

    Returns the result of the method call, wrapped by generatorModifier to
    handle generator/iterator return values, and abbreviateStackTrace to
    produce R-friendly tracebacks on error.
    """
    patch_stdout_stderr()
    method = kwargs["method"]
    args = kwargs["args"]
    kw = dict(kwargs["kwargs"])
    method_to_call = getattr(method[0], method[1])
    return generatorModifier(abbreviateStackTrace(lambda: method_to_call(*args, **kw)))
