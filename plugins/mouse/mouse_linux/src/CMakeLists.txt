# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(mouse_linux_library VERSION 0.0.1 LANGUAGES C)

add_library(mouse_linux SHARED
  "mouse_linux.c"
)

set_target_properties(mouse_linux PROPERTIES
  PUBLIC_HEADER mouse_linux.h
  OUTPUT_NAME "mouse_linux"
)

target_compile_definitions(mouse_linux PUBLIC DART_SHARED_LIB)
