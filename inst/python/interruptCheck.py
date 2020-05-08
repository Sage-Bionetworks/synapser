import ctypes
from synapseclient.core import dozer

class InterruptChecker:
    def __init__(self, sharedLibrary):
        peirModule=ctypes.CDLL(sharedLibrary)
        self.peirModule=peirModule
        
    def __call__(self):
        result=self.peirModule.checkInterrupt()
        if result!=0:
            raise ValueError("keyboard interrupt received")

def registerInterruptChecker(sharedLibrary):
    interruptChecker = InterruptChecker(sharedLibrary)
    dozer.add_listener(interruptChecker)
