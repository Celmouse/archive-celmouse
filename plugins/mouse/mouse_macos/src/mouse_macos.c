#include "mouse_macos.h"
#include <ApplicationServices/ApplicationServices.h>

FFI_PLUGIN_EXPORT void mouse_move(float a, float b)
{
  CGEventRef moveEvent = CGEventCreateMouseEvent(
      NULL,
      kCGEventMouseMoved,
      CGPointMake(a, b),
      kCGEventLeftMouseDown);

  CGEventPost(kCGHIDEventTap, moveEvent);
  CFRelease(moveEvent);
}
