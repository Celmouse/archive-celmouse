# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(keyboard_macos_library VERSION 0.0.1 LANGUAGES C)

add_library(keyboard_macos SHARED
  "keyboard_macos.c"
)

set_target_properties(keyboard_macos PROPERTIES
  PUBLIC_HEADER keyboard_macos.h
  OUTPUT_NAME "keyboard_macos"
)

target_compile_definitions(keyboard_macos PUBLIC DART_SHARED_LIB)