#include "keyboard_macos.h"
#include <stdio.h>

#include <ApplicationServices/ApplicationServices.h>

FFI_PLUGIN_EXPORT void pressKeyboardKey(char key)
{
  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, key, true);

  CGEventPost(kCGHIDEventTap, keyDown);
  CFRelease(keyDown);
}

FFI_PLUGIN_EXPORT void releaseKeyboardKey(int key)
{
  CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, key, false);

  CGEventPost(kCGHIDEventTap, keyUp);
  CFRelease(keyUp);
}
