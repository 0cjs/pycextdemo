pycestdemo - Python C/C++ Extension Demo
========================================

My try at making a simple CPython extension written in C.


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
