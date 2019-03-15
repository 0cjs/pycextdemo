cmake_minimum_required(VERSION 3.12)
project(pycextdemo)

enable_testing()
add_test(NAME TestNothing COMMAND true)

add_subdirectory(hello)
add_subdirectory(pyext)
