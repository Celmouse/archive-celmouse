# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(mouse_library VERSION 0.0.1 LANGUAGES C)

add_library(mouse SHARED
  "mouse.c"
)

set_target_properties(mouse PROPERTIES
  PUBLIC_HEADER mouse.h
  OUTPUT_NAME "mouse"
)

target_compile_definitions(mouse PUBLIC DART_SHARED_LIB)
