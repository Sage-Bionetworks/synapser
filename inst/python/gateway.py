import synapseclient
import types
from abbreviateStackTrace import abbreviateStackTrace
from patchStdoutStdErr import patch_stdout_stderr
from synapseclient.annotations import Annotations

class GeneratorWrapper():
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

def annotationsModifier(a):
    # convert to a simple dictionary
    if isinstance(a, Annotations):
        return a.copy()
    else:
        return a

# args[0] is an object and args[1] is a method name.  args[2:] and kwargs are the method's arguments
def invoke(*args, **kwargs):
    patch_stdout_stderr()
    method_to_call = getattr(args[0], args[1])
    return annotationsModifier(generatorModifier(abbreviateStackTrace(lambda: method_to_call(*args[2:], **kwargs))))


