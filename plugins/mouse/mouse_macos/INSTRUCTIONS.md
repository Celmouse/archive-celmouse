# Integration Guide for Third-Party Plugin

## Step-by-Step Guide

### Step 1: Clone the Third-Party Plugin
1. Navigate to your project directory:
    ```sh
    cd /Users/marceloviana/dev/gyromouse/plugins/mouse/mouse_macos
    ```
2. Clone the third-party plugin repository:
    ```sh
    git clone https://github.com/example/robot-cpp.git third_party/robot-cpp
    ```

### Step 2: Build the Third-Party Plugin

1. Navigate to the third-party plugin directory:
    ```sh
    cd third_party/robot-cpp
    ```
2. Follow the build instructions provided in the plugin's documentation. Typically, this involves running:
    ```sh
    mkdir build
    cd build
    cmake ..
    make
    ```

### Step 3: Integrate with Existing C Code
1. Create an interface header file in `src/` to connect the C++ plugin with your C code. For example, create `src/robot_interface.h`:
    ```c
    #ifndef ROBOT_INTERFACE_H
    #define ROBOT_INTERFACE_H

    #ifdef __cplusplus
    extern "C" {
    #endif

    void initialize_robot();
    void perform_robot_action();

    #ifdef __cplusplus
    }
    #endif

    #endif // ROBOT_INTERFACE_H
    ```

2. Implement the interface in `src/robot_interface.cpp`:
    ```cpp
    #include "robot_interface.h"
    #include "third_party/robot-cpp/robot.h"

    void initialize_robot() {
        Robot::initialize();
    }

    void perform_robot_action() {
        Robot::performAction();
    }
    ```

### Step 4: Update Build System
1. Modify your build system (e.g., CMakeLists.txt) to include the third-party plugin and the new interface files:
    ```cmake
    add_subdirectory(third_party/robot-cpp)
    add_library(robot_interface src/robot_interface.cpp)
    target_link_libraries(robot_interface robot-cpp)
    ```

### Step 5: Generate Dart Bindings
1. Create a `ffigen.yaml` file in your project root:
    ```yaml
    name: 'robot_bindings'
    description: 'Dart bindings for the robot interface'
    output: 'lib/src/robot_bindings.dart'
    headers:
      entry-points:
        - 'src/robot_interface.h'
    ```

2. Run the ffigen tool to generate the Dart bindings:
    ```sh
    dart run ffigen
    ```

### Step 6: Use the Generated Bindings in Dart
1. Import the generated bindings in your Dart code:
    ```dart
    import 'package:robot_bindings/robot_bindings.dart';

    void main() {
      initialize_robot();
      perform_robot_action();
    }
    ```

Follow these steps to successfully integrate the third-party C++ plugin with your existing C code and generate Dart bindings using ffigen.