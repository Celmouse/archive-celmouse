#include "mouse_linux.h"
#include <X11/Xlib.h>
#include <X11/extensions/XTest.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// Global X11 display connection
static Display* display = NULL;

// Initialize X11 connection
static bool initX11(void) {
    if (display == NULL) {
        display = XOpenDisplay(NULL);
        if (display == NULL) {
            fprintf(stderr, "Error: Could not open X11 display\n");
            return false;
        }
    }
    return true;
}

// Clean up X11 connection
static void cleanupX11(void) {
    if (display != NULL) {
        XCloseDisplay(display);
        display = NULL;
    }
}

// Get current mouse position
static XPoint getCurrentMousePosition(void) {
    XPoint point = {0, 0};
    Window root, child;
    int root_x, root_y, win_x, win_y;
    unsigned int mask;

    if (!initX11()) {
        return point;
    }

    Window rootWindow = DefaultRootWindow(display);
    if (XQueryPointer(display, rootWindow, &root, &child,
                      &root_x, &root_y, &win_x, &win_y, &mask)) {
        point.x = root_x;
        point.y = root_y;
    }

    return point;
}

FFI_PLUGIN_EXPORT void MouseMove(float x, float y) {
    if (!initX11()) return;

    XPoint currentPos = getCurrentMousePosition();
    int new_x = currentPos.x + (int)x;
    int new_y = currentPos.y + (int)y;

    Window rootWindow = DefaultRootWindow(display);
    XWarpPointer(display, None, rootWindow, 0, 0, 0, 0, new_x, new_y);
    XFlush(display);
}

FFI_PLUGIN_EXPORT void MouseMoveTo(float x, float y) {
    if (!initX11()) return;

    Window rootWindow = DefaultRootWindow(display);
    XWarpPointer(display, None, rootWindow, 0, 0, 0, 0, (int)x, (int)y);
    XFlush(display);
}

FFI_PLUGIN_EXPORT void DoubleClick(void) {
    if (!initX11()) return;

    // Simulate double click with proper timing
    XTestFakeButtonEvent(display, 1, True, 0);  // Press
    XTestFakeButtonEvent(display, 1, False, 0); // Release
    usleep(10000);  // 10ms delay between clicks
    XTestFakeButtonEvent(display, 1, True, 0);  // Press
    XTestFakeButtonEvent(display, 1, False, 0); // Release
    XFlush(display);
}

FFI_PLUGIN_EXPORT void MouseScroll(int x, int y, int amount) {
    if (!initX11()) return;

    // X11 uses button 4 for scroll up and button 5 for scroll down
    int button;
    int iterations = abs(amount);
    
    // Vertical scrolling
    if (y != 0) {
        button = (y > 0) ? 4 : 5;  // 4 is up, 5 is down
        for (int i = 0; i < iterations; i++) {
            XTestFakeButtonEvent(display, button, True, 0);
            XTestFakeButtonEvent(display, button, False, 0);
        }
    }

    // Horizontal scrolling (buttons 6 and 7 if available)
    if (x != 0) {
        button = (x > 0) ? 6 : 7;  // 6 is right, 7 is left
        for (int i = 0; i < iterations; i++) {
            XTestFakeButtonEvent(display, button, True, 0);
            XTestFakeButtonEvent(display, button, False, 0);
        }
    }

    XFlush(display);
}

FFI_PLUGIN_EXPORT void MouseClick(MouseButton button) {
    if (!initX11()) return;

    int x11_button;
    switch (button) {
        case kMouseButtonLeft:
            x11_button = 1;
            break;
        case kMouseButtonRight:
            x11_button = 3;
            break;
        case kMouseButtonMiddle:
            x11_button = 2;
            break;
        default:
            fprintf(stderr, "Error: Invalid mouse button\n");
            return;
    }

    XTestFakeButtonEvent(display, x11_button, True, 0);  // Press
    XTestFakeButtonEvent(display, x11_button, False, 0); // Release
    XFlush(display);
}

FFI_PLUGIN_EXPORT void MouseHoldLeftButton(void) {
    if (!initX11()) return;

    XTestFakeButtonEvent(display, 1, True, 0);  // Press
    XFlush(display);
}

FFI_PLUGIN_EXPORT void MouseReleaseLeftButton(void) {
    if (!initX11()) return;

    XTestFakeButtonEvent(display, 1, False, 0);  // Release
    XFlush(display);
}

// Cleanup function to be called when the library is unloaded
__attribute__((destructor))
static void cleanup(void) {
    cleanupX11();
}