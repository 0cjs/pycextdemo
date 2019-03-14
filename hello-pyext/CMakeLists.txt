cmake_minimum_required(VERSION 3.12)
project(hello-pyext)

#   On Windows when using FindPython3 one has to be careful to make
#   sure that you're using (in our case) 64-bit libs and interpreter
#   and have set CMake to do a 64-bit build. For more details see:
#     https://gitlab.kitware.com/cmake/cmake/issues/19024
find_package(Python3 COMPONENTS Interpreter Development)
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

Python3_add_library(phello MODULE helloext)
target_link_libraries(phello PRIVATE hello)

####################################################################
#   Tests

enable_testing()

add_test(NAME pythonversion COMMAND ${Python3_EXECUTABLE} --version)
set_tests_properties(pythonversion PROPERTIES
    PASS_REGULAR_EXPRESSION "^Python 3\.[4-7]")

configure_file(test.py test.py)     # Copy to binary dir so .so is in path
add_test(NAME pythonext
    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/test.py)
