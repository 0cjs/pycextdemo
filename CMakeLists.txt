cmake_minimum_required(VERSION 3.12)
project(demo)

enable_testing()
add_test(TestNothing true)

message("===== top: start")
add_subdirectory(one)
add_subdirectory(three)
message("===== top: end")
