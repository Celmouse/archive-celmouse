# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(mouse_macos_library VERSION 0.0.1 LANGUAGES C)

add_library(mouse_macos SHARED
  "mouse_macos.c"
)

set_target_properties(mouse_macos PROPERTIES
  PUBLIC_HEADER mouse_macos.h
  OUTPUT_NAME "mouse_macos"
)

target_compile_definitions(mouse_macos PUBLIC DART_SHARED_LIB)