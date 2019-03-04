cmake_minimum_required(VERSION 3.12)
project(one)

set(x one)
message("one: x=${x}")

message("one: add one-two")
add_subdirectory(../two one-two)

#   Show inheritance follows add_subdirectory() call chain, not source
#   or build directory location.
#   * Neither source nor build dir of `top-two` is under `one` yet it
#     prints x=one inherited from us, not x=demo inherited from top.
#   * `two` added from `top` did print x=demo however.
message("one: add ../top-two")
add_subdirectory(../two ../top-two)
