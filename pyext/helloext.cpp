#include <Python.h>
#include "greet.h"

// Based on examples from Python extension documentation:
// https://docs.python.org/3/extending/extending.html#a-simple-example

extern "C" {
    // Anything we'd be directly calling from outside code,
    // particuarly if Python were directly grovelling functions in
    // this file, would probably want to be declared with C
    // naming/calling conventions. However, in our case the internal
    // static functions can use whatever names they like since
    // PyInit_phello() takes care of doing registration (specifying
    // the munged name actually used in the `.so` file).
}

static PyObject * seven(PyObject *self, PyObject *args)  {
    // self: module owning function or object owning method
    // args: tuple of arguments (parse with PyArg_ParseTuple())
    // No METH_KEYWORDS, no no third `PyObject *kwargs` dict.
    int value = 7;
    return PyLong_FromLong(value);
}

//  This assumes that all `char *` are UTF-8 strings.
static PyObject * pygreet(PyObject *self, PyObject *args)  {
    //  XXX How do we decode the args?
    const char *name = NULL;
    if (!PyArg_ParseTuple(args, "s", &name))
        return NULL;
    return PyUnicode_FromString(greet(name));
}

static PyMethodDef methods[] = {
    {"seven", seven, METH_VARARGS, "Return integer 7"},
    {"greet", pygreet, METH_VARARGS, "Greet the passed name"},
    {NULL, NULL, 0, NULL}
};


static struct PyModuleDef module = {
    PyModuleDef_HEAD_INIT,
    "phello",       // module name
    NULL,           // module documentation
    -1,             // per-interp state size; -1 = state in globals
    methods
};

// PyMODINIT_FUNC declares this function as extern "C"
PyMODINIT_FUNC PyInit_phello(void)  {
    return PyModule_Create(&module);
}
