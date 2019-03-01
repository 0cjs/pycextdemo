cmake_minimum_required(VERSION 3.12)
project(one)

message("===== top/one: start")
add_subdirectory(two)
message("===== top/one: end")
