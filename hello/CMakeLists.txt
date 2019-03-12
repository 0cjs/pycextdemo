cmake_minimum_required(VERSION 3.12)
project(hello)

add_library(hello STATIC greet)
target_include_directories(hello INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(greet greetmain)
target_link_libraries(greet hello)

enable_testing()
add_test(NAME testgreet COMMAND greet George)
set_tests_properties(testgreet PROPERTIES
    PASS_REGULAR_EXPRESSION "^Hello, George\\.\n$") # Double escape for `.`
