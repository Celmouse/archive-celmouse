#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// #if defined(_WIN32) || defined(_WIN64)
// #include <windows.h>

// #elif defined(__APPLE__)
// #include <ApplicationServices/ApplicationServices.h>

// #else // Linux com X11
// #include <X11/Xlib.h>

// #endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif


# define CGFLOAT_TYPE double
typedef CGFLOAT_TYPE CGFloat;

typedef struct
{
    CGFloat x;
    CGFloat y;
} MousePosition;

FFI_PLUGIN_EXPORT void move_mouse(CGFloat a, CGFloat b);
FFI_PLUGIN_EXPORT MousePosition get_mouse_position(void);
