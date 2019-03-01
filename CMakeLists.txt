cmake_minimum_required(VERSION 3.12)
project(demo)

enable_testing()
add_test(TestNothing true)

message("===== top: start")

#   Initial values to inherit
set(datum INITIAL_DATUM)
set(datum_value INITIAL_DATUM_VALUE)

add_subdirectory(one)
add_subdirectory(three)

#   Changed by subdir? No, because subdir started a new scope.
message("datum=${datum} datum_value=${datum_value}")

#   Variable
message(CMAKE_BUILD_TOOL=${CMAKE_BUILD_TOOL})
get_property(prop GLOBAL PROPERTY CMAKE_BUILD_TOOL)
message(CMAKE_BUILD_TOOL.prop=${prop})

# Empty: properties are not vars
message(SUBDIRECTORIES=${SUBDIRECTORIES})

#   Property on current dir
foreach(datum "" SET DEFINED BRIEF_DOCS FULL_DOCS)
    get_property(datum_value DIRECTORY PROPERTY SUBDIRECTORIES ${datum})
    message(SUBDIRECTORIES.${datum}=${datum_value})
endforeach()

#   Property on subdir
foreach(datum "" SET DEFINED BRIEF_DOCS FULL_DOCS)
    get_property(datum_value DIRECTORY one PROPERTY SUBDIRECTORIES ${datum})
    message(one.SUBDIRECTORIES.${datum}=${datum_value})
endforeach()

message("===== top: end")
