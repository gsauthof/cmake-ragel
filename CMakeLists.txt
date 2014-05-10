# This file is just needed for building the examples.
#
# It demonstrates how to use the FindRAGEL module.
#
# 2014-05-10, Georg Sauthoff <mail@georg.so>

cmake_minimum_required(VERSION 2.8)
project(cmake_ragel_example CXX C)


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR})

# When you include this module as git submodule in your project, use something
# like (assuming that it is imported under project/cmake/ragel):
#
# set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake/ragel)


find_package(RAGEL 6.6 REQUIRED)


# First example - lexing decimal numbers - from the Ragel manual

RAGEL_TARGET(number example/number.rl ${CMAKE_CURRENT_BINARY_DIR}/number.c)
add_executable(number ${RAGEL_number_OUTPUTS})

# Second example - used the stack feature of Ragel to parse
# nested structures

RAGEL_TARGET(nested example/nested.rl ${CMAKE_CURRENT_BINARY_DIR}/nested.cc)

add_executable(nested ${RAGEL_nested_OUTPUTS})
