# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(mouse_windows_library VERSION 0.0.1 LANGUAGES C)

add_library(mouse_windows SHARED
  "mouse_windows.c"
)

set_target_properties(mouse_windows PROPERTIES
  PUBLIC_HEADER mouse_windows.h
  OUTPUT_NAME "mouse_windows"
)

target_compile_definitions(mouse_windows PUBLIC DART_SHARED_LIB)
