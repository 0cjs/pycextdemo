cmake_minimum_required(VERSION 3.12)
project(hello-pyext)

include(FindPython3)
find_package(Python3 COMPONENTS Interpreter Development)
message(STATUS "Python interpreter: ${Python3_EXECUTABLE}")
if(NOT ${Python3_Development_FOUND})
    #   XXX do we need this since we have `Development` above?
    message(FATAL_ERROR "Python3 development libs not found.")
endif()

####################################################################
#   Extension module

add_library(phello SHARED helloext.cpp)
set_target_properties(phello PROPERTIES PREFIX "")  # Unix: no 'lib' prefix
target_include_directories(phello PRIVATE ${Python3_INCLUDE_DIRS})

####################################################################
#   Tests

enable_testing()

add_test(pythonversion ${Python3_EXECUTABLE} --version)
set_tests_properties(pythonversion PROPERTIES
    PASS_REGULAR_EXPRESSION "^Python 3\.[4-7]")

configure_file(test.py test.py)     # Copy to binary dir so .so is in path
add_test(pythonext ${Python3_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/test.py)
set_tests_properties(pythonext PROPERTIES
    PASS_REGULAR_EXPRESSION "^OK\n$")
