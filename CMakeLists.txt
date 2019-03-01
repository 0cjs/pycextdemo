cmake_minimum_required(VERSION 3.12)
project(demo)

enable_testing()
add_test(TestNothing true)

#   Var lookup works because if the var is not set, looks up in cache?
message("         CMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
message("  CACHE{CMAKE_C_COMPILER}=$CACHE{CMAKE_C_COMPILER}")
message("    ENV{CMAKE_C_COMPILER}=$ENV{CMAKE_C_COMPILER}")

get_property(cmcc GLOBAL PROPERTY CMAKE_C_COMPILER)
message("get_property(cmcc GLOBAL)=${cmcc}")

get_property(cmcc CACHE CMAKE_C_COMPILER PROPERTY VALUE)
message(" get_property(cmcc CACHE)=${cmcc}")
