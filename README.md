pycextdemo - Python C/C++ Extension Demo
========================================

This is currently serving as a test jig for experimentation with using
CMake to build C/C++ code and a Python extension under both Linux and
Windows.

Current only Windows only 64-bit builds are supported.


Building
--------

### Test Script

On both Linux and Windows, running `./Test` in the top-level directory
will configure, build and test the repo. Output will be placed in the
`.build/` directory.

The following options are available:
- `-v`: Verbose output, needed to see what tests are run and failure output.
- `-C`: Clean build; removes all of `.build/` at start.
- `-n`: Use Ninja generator; can only be used with a clean build.
- `-t`: Specify a target for the build.

#### Linux Notes

Because the OS-supplied version of CMake tends to be old even on
recent LTS releases, `Test` will download and install under `.build/`
a local copy of a recent version of CMake. You can run that version
manually with `.build/cmake-*/bin/cmake`.

A Makefile generator will be used unless `-n` is given to use Ninja.

#### Windows Notes

In Windows you need to run `./Test` in a MinGW Bash shell such as the
one provided by Git for Windows. It will look for the CMake supplied
by Visual Studio 2017 (Professional or Community) and use that. You
may need to update your Visual Studio packages to ensure it has the
latest version of CMake distributed by MS.

The build will (or should) be 64-bit; 32-bit builds are not supported
by this repo.

An MSBuild generator will be used unless `-n` is given to use Ninja.
Since MSBuild is multi-configuration, you may want/need to change the
script to build a with a different `--config`.

### Visual Studio

Visual Studio 2017 [supports CMake projects][vs-cmake]; use "File /
Open / Folder" to open this directory. You will need to manually set
your build configuration to "x64-Release". VS appears to use the Ninja
generator and places output under `C:\Users\USERNAME\CMakeBuilds\`;
use the "CMake / Cache" menu to find the exact subdir.

You should also be able to open Visual Studio's "x64 Native Tools
Command Prompt for VS 2017" and do command-line builds either in the
directory above or in a fresh build directory.


Helper Libraries
----------------

Rather than manually writing all the CPython API you could use on of the
following to deal with a lot of that for you:
- [pybind11], which also provides a CMake build command
- [Boost.Python]
- [brujeria]: Hooks to compile on import; uses CMake and [IXM]


Other Options
-------------

The `ctypes` module or the `cffi` library may be easier to use, and
will also work with Python implementations other than CPython.



<!-------------------------------------------------------------------->
[Boost.Python]: http://www.boost.org/doc/libs/release/libs/python/doc/
[IXM]: https://ixm.one/
[brujeria]: https://github.com/slurps-mad-rips/brujeria
[pybind11]: https://pybind11.readthedocs.io/
[vs-cmake]: https://github.com/0cjs/sedoc/blob/master/lang/cmake/visualstudio.md
