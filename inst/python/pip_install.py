"""
Utility functions for installing/removing pip packages programatically
"""

import glob
import inspect
import os
import shutil
import subprocess
import sys


def _find_python_interpreter():
    # helper heuristic to find the bundled python interpreter binary associated
    # with PythonEmbedInR. we need it in order to be able to invoke pip via
    # a subprocess. it's not in the same place because of how we build
    # PythonEmbedInR differently between the OSes.

    possible_interpreter_filenames = [
        'python',
        'python{}'.format(sys.version_info.major),
        'python{}.{}'.format(sys.version_info.major, sys.version_info.minor),
    ]
    possible_interpreter_filenames.extend(['{}.exe'.format(f) for f in possible_interpreter_filenames])
    possible_interpreter_filenames.extend([os.path.join('bin', f).format(f) for f in possible_interpreter_filenames])

    last_path = None
    path = inspect.getfile(os)
    while(path and path != last_path):
        for f in possible_interpreter_filenames:
            file_path = os.path.join(path, f)
            if os.path.isfile(file_path) and os.access(file_path, os.X_OK):
                return file_path

        last_path = path
        path = os.path.dirname(path)

    # if we didn't find anything we'll hope there is any 'python3' interpreter on the path.
    # we're just going to use it to install some modules into a specific directory
    # so it doesn't actually even have to be the one bundled with PythonEmbedInR
    return 'python{}'.format(sys.version_info.major)


PYTHON_INTERPRETER = _find_python_interpreter()


def install(package, package_dir):
    """
    Programatically install a package via pip
    :param package: the name of the python package to install via pip
    :param package_dir: the directory to install the package into
    """

    # the recommended way to call pip at runtime is by invoking a subprocess,
    # but that's complicated by the fact that we don't know where the python
    # interpreter is. usually you can do sys.executable but in the embedded
    # context sys.executable is R, not python. So we do a heuristic to
    # find the interpreter. this seems to work better here than calling main
    # on pip directly which doesn't work for some of these packages (separately
    # from the other issues above...)
    print(f'Attempting to pip install {package} in {package_dir}')
    print(f'Python: {PYTHON_INTERPRETER}')
    # rc = subprocess.call([PYTHON_INTERPRETER, "-m", "pip", "install", package, "--upgrade", "--quiet", "--target", package_dir])
    rc = subprocess.call(["pip", "install", package, "--upgrade", "--target", package_dir])
    if rc != 0:
        print("pip returned {} when installing {}".format(rc, package))
        raise Exception("pip returned {} when installing {}".format(rc, package))
    print(f'{package} installed')


def remove(prefix, package_dir):
    """
    Remove a package installed via this script.
    :param prefix: a package or package prefix
    :param package_dir: the directory the package was installed into
    """

    # pip doesn't offer a way to uninstall from a specific target directory.
    # instead we delete all traces matching the given prefix
    to_remove = glob.iglob(os.path.join(package_dir, prefix+"*"))
    for path in to_remove:
      if os.path.isdir(path):
        shutil.rmtree(path)

