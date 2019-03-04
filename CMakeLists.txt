cmake_minimum_required(VERSION 3.12)
project(scoping-demo)

enable_testing()
add_test(TestNothing true)


function(f2)
    message("  f2: x=${x} (inherited)")
endfunction()

function(f1)
    message("  f1: x=${x} (inherited)")
    unset(x)
    message("  f1: x=${x} (unset)")
    f2()
endfunction()

set(x top)
message(" top: x=${x}")
f1()

#   On a first clean run without `-Dx=value`, f1() and f2() will print
#   `x` as empty string. On subsequent runs it will print `x` as
#   `cachedvar` because that value is preserved across runs.
message("Setting cache entry with set():")
#   Does not override any existing cache setting.
set(x cachedvar CACHE STRING "test cache property")
message(" top: x=${x}")
f1()

#   Show use of get_property() to retrive cache property and variable values.
get_property(xval CACHE x PROPERTY VALUE)
message(" top: xval=${xval} (get_property(CACHE))")
get_property(xval VARIABLE PROPERTY x)
message(" top: xval=${xval} (get_property(VARIABLE))")
unset(xval)

message("Setting cache entry with set_property():")
set_property(CACHE x PROPERTY VALUE cachedprop)
message(" top: x=${x}")
f1()

# Neither GLOBAL nor DIRECTORY properties are variables or looked up
# by variable expansion.

message("Setting GLOBAL property xg:")
set_property(GLOBAL PROPERTY xg globalized)
message(" top: xg=${xg}")

message("Setting DIRECTORY property xd:")
set_property(DIRECTORY PROPERTY xd directized)
message(" top: xd=${xd}")
