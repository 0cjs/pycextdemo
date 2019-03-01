cmake_minimum_required(VERSION 3.12)
project(one)

message("===== top/one: start")
add_subdirectory(two)

#   Inherit from above?
message("datum=${datum} datum_value=${datum_value}")

#   Property on current dir
get_property(datum_value DIRECTORY PROPERTY SUBDIRECTORIES)
message(SUBDIRECTORIES.=${datum_value})

#   Reset here
message("datum=${datum} datum_value=${datum_value}")

message("===== top/one: end")
