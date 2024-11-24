#include "mouse_macos.h"

#include <ApplicationServices/ApplicationServices.h>

CGPoint getCurrentMousePosition(void)
{
  CGEventRef event = CGEventCreate(NULL);
  CGPoint cursor = CGEventGetLocation(event);
  CFRelease(event);
  return cursor;
}
FFI_PLUGIN_EXPORT void MouseMove(float x, float y)
{
  CGPoint currentPos = getCurrentMousePosition();
  CGPoint newPos = CGPointMake(currentPos.x + x, currentPos.y + y);
  CGEventRef move = CGEventCreateMouseEvent(NULL, kCGEventMouseMoved, newPos, kCGMouseButtonLeft);
  CGEventPost(kCGHIDEventTap, move);
  CFRelease(move);
}

FFI_PLUGIN_EXPORT void MouseMoveTo(float x, float y)
{
  CGEventRef move = CGEventCreateMouseEvent(NULL, kCGEventMouseMoved, CGPointMake(x, y), kCGMouseButtonLeft);
  CGEventPost(kCGHIDEventTap, move);
  CFRelease(move);
}

FFI_PLUGIN_EXPORT void DoubleClick(void)
{
  CGPoint currentPos = getCurrentMousePosition();

  // Cria o evento de clique duplo
  CGEventRef mouseDoubleClick = CGEventCreateMouseEvent(
      NULL, kCGEventLeftMouseDown, currentPos, 0);
  CGEventSetIntegerValueField(mouseDoubleClick, kCGMouseEventClickState, 2);
  CGEventPost(kCGHIDEventTap, mouseDoubleClick);
  CFRelease(mouseDoubleClick);

  // Cria o evento de soltar
  CGEventRef mouseUp = CGEventCreateMouseEvent(
      NULL, kCGEventLeftMouseUp, currentPos, 0);
  CGEventPost(kCGHIDEventTap, mouseUp);
  CFRelease(mouseUp);
}

FFI_PLUGIN_EXPORT void MouseScroll(int x, int y, int amount)
{
  CGEventRef scroll = CGEventCreateScrollWheelEvent(NULL, kCGScrollEventUnitPixel, 2, y * amount, x * amount);
  CGEventPost(kCGHIDEventTap, scroll);
  CFRelease(scroll);
}

FFI_PLUGIN_EXPORT void MouseClick(MouseButton button)
{
  CGEventType downEvent, upEvent;
  switch (button)
  {
  case kMouseButtonLeft:
    downEvent = kCGEventLeftMouseDown;
    upEvent = kCGEventLeftMouseUp;
    break;
  case kMouseButtonRight:
    downEvent = kCGEventRightMouseDown;
    upEvent = kCGEventRightMouseUp;
    break;
  case kMouseButtonMiddle:
    downEvent = kCGEventOtherMouseDown;
    upEvent = kCGEventOtherMouseUp;
    break;
  default:
    return;
  }

  CGPoint currentPos = getCurrentMousePosition();
  CGEventRef click_down = CGEventCreateMouseEvent(NULL, downEvent, currentPos, button);
  CGEventRef click_up = CGEventCreateMouseEvent(NULL, upEvent, currentPos, button);

  CGEventPost(kCGHIDEventTap, click_down);
  CGEventPost(kCGHIDEventTap, click_up);

  CFRelease(click_down);
  CFRelease(click_up);
}

FFI_PLUGIN_EXPORT void MouseHoldLeftButton(void)
{
  CGEventRef hold = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, getCurrentMousePosition(), kCGMouseButtonLeft);
  CGEventPost(kCGHIDEventTap, hold);
  CFRelease(hold);
}

FFI_PLUGIN_EXPORT void MouseReleaseLeftButton(void)
{
  CGEventRef release = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, getCurrentMousePosition(), kCGMouseButtonLeft);
  CGEventPost(kCGHIDEventTap, release);
  CFRelease(release);
}
