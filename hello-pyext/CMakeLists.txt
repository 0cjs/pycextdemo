cmake_minimum_required(VERSION 3.12)
project(hello-pyext)

#   The FindPython3 package (though 3.14.00-rc3) works fine on
#   Linux but can't find the interpreter on Windows. For more
#   details see:
#     https://stackoverflow.com/q/55021986/107294
#     https://gitlab.kitware.com/cmake/cmake/issues/19024
#find_package(Python3 COMPONENTS Interpreter Development)
#
#   Beacuse of this, we instead use FindPython{Interp,Libs}.
#   This is deprecated since 3.12 but still present in 3.14.
set(Python_ADDITIONAL_VERSIONS 3.7 3.6 3.5 3.4)
find_package(PythonInterp)
find_package(PythonLibs)
#   This hack sets a subset of the FindPython3 variables based on the
#   FindPython{Interp,Libs} results so that when the former starts
#   working for us we don't need to change the rest of the code.
set(Python3_FOUND ${PYTHONINTERP_FOUND})
set(Python3_Interpreter_FOUND ${PYTHONINTERP_FOUND})
set(Python3_VERSION ${PYTHON_VERSION_STRING})
set(Python3_EXECUTABLE ${PYTHON_EXECUTABLE})
set(Python3_Development_FOUND ${PYTHONLIBS_FOUND})
set(Python3_INCLUDE_DIRS ${PYTHON_INCLUDE_DIRS})
set(Python3_LIBRARIES ${PYTHON_LIBRARIES})
# PYTHONLIBS_VERSION_STRING should be the same as PYTHON_VERSION_STRING

message(STATUS
    "Python: version=${Python3_VERSION} interpreter=${Python3_EXECUTABLE}")
if(NOT Python3_FOUND OR NOT Python3_Development_FOUND)
    #   find_package() will not abort the build if anything's missing.
    string(JOIN "\n" errmsg
        "  Python3 and/or development libs not found."
        "  - Python3_FOUND=${Python3_FOUND}"
        "  - Python3_Development_FOUND=${Python3_Development_FOUND}"
        )
    message(FATAL_ERROR ${errmsg})
endif()

####################################################################
#   Extension module

add_library(phello SHARED helloext)
set_target_properties(phello PROPERTIES PREFIX "")  # Unix: no 'lib' prefix
target_include_directories(phello PRIVATE ${Python3_INCLUDE_DIRS})

####################################################################
#   Tests

enable_testing()

add_test(NAME pythonversion COMMAND ${Python3_EXECUTABLE} --version)
set_tests_properties(pythonversion PROPERTIES
    PASS_REGULAR_EXPRESSION "^Python 3\.[4-7]")

configure_file(test.py test.py)     # Copy to binary dir so .so is in path
add_test(NAME pythonext
    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/test.py)
