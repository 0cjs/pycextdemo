#   Get a list of all properties from CMake and supply a function that
#   will attempt to print each of those property values on a given target.
#   Adapted from: https://stackoverflow.com/a/34292622/107294
#
#   Calling
#       include(${CMAKE_SOURCE_DIR}/libcmake/printproplist.cmake)
#   will enable the print_properties() and print_target_properties(tgt)
#   functions.
#
#   This is protected against multiple includes, but not well tested,
#   especially as far as variable scope is concerned.

include_guard(GLOBAL)

# Get all propreties that cmake supports
execute_process(
    COMMAND cmake --help-property-list
    OUTPUT_VARIABLE CMAKE_PROPERTY_LIST)

# Convert command output into a CMake list
STRING(REGEX REPLACE ";" "\\\\;" CMAKE_PROPERTY_LIST "${CMAKE_PROPERTY_LIST}")
STRING(REGEX REPLACE "\n" ";" CMAKE_PROPERTY_LIST "${CMAKE_PROPERTY_LIST}")

function(print_properties)
    message ("CMAKE_PROPERTY_LIST = ${CMAKE_PROPERTY_LIST}")
endfunction()

function(print_target_properties tgt)
    if(NOT TARGET ${tgt})
      message("There is no target named '${tgt}'")
      return()
    endif()

    foreach (prop ${CMAKE_PROPERTY_LIST})
        string(REPLACE "<CONFIG>" "${CMAKE_BUILD_TYPE}" prop ${prop})
    # Fix https://stackoverflow.com/questions/32197663/how-can-i-remove-the-the-location-property-may-not-be-read-from-target-error-i
    if(   prop STREQUAL "LOCATION"
       OR prop MATCHES "^LOCATION_"
       OR prop MATCHES "_LOCATION$"
       )
        continue()
    endif()
        # message ("Checking ${prop}")
        get_property(propval TARGET ${tgt} PROPERTY ${prop} SET)
        if (propval)
            get_target_property(propval ${tgt} ${prop})
            message ("${tgt} ${prop} = ${propval}")
        endif()
    endforeach(prop)
endfunction()
