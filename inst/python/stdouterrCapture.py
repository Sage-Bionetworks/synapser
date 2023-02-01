from patchStdoutStdErr import patch_stdout_stderr

# Note stdouterrCapture is no longer used but is temporarily maintained for backwards compatibility
def stdouterrCapture(function, abbreviateStackTrace=False):
    patch_stdout_stderr()
    return function()
