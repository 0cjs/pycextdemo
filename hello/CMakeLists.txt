cmake_minimum_required(VERSION 3.7)
project(hello)

add_library(hello STATIC greet)

add_executable(greet greetmain)
target_link_libraries(greet hello)

enable_testing()
add_test(testgreet greet George)
set_tests_properties(testgreet PROPERTIES
    PASS_REGULAR_EXPRESSION "^Hello, George\\.\n$") # Double escape for `.`
