#ifndef MOUSE_LINUX_H
#define MOUSE_LINUX_H

#include <stdbool.h>
#include <X11/Xlib.h>

// Define the FFI export macro if not already defined
#ifndef FFI_PLUGIN_EXPORT
#define FFI_PLUGIN_EXPORT __attribute__((visibility("default"))) extern
#endif

// Mouse button enumeration
typedef enum {
    kMouseButtonLeft = 1,
    kMouseButtonRight = 3,
    kMouseButtonMiddle = 2
} MouseButton;

// Function declarations
FFI_PLUGIN_EXPORT void MouseMove(float x, float y);
FFI_PLUGIN_EXPORT void MouseMoveTo(float x, float y);
FFI_PLUGIN_EXPORT void DoubleClick(void);
FFI_PLUGIN_EXPORT void MouseScroll(int x, int y, int amount);
FFI_PLUGIN_EXPORT void MouseClick(MouseButton button);
FFI_PLUGIN_EXPORT void MouseHoldLeftButton(void);
FFI_PLUGIN_EXPORT void MouseReleaseLeftButton(void);

#endif // MOUSE_LINUX_H