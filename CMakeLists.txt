cmake_minimum_required(VERSION 3.12)
project(top)

enable_testing()
add_test(TestNothing true)

set(x top)
message("top: x=${x}")

message("top: add one")
add_subdirectory(one)

message("top: add two")
add_subdirectory(two)
