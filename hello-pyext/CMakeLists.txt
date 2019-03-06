cmake_minimum_required(VERSION 3.12)
project(hello-pyext)

find_package(Python3 COMPONENTS Interpreter Development)
message(STATUS "Python interpreter: ${Python3_EXECUTABLE}")
if(NOT Python3_FOUND AND Python3_Development_FOUND)
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
set_tests_properties(pythonext PROPERTIES
    PASS_REGULAR_EXPRESSION "^OK\n$")
