#include "keyboard_macos.h"
// #include <CoreFoundation/CoreFoundation.h>
// #include <Carbon/Carbon.h> 
#include <ApplicationServices/ApplicationServices.h>
// #include <CoreGraphics/CGEvent.h> // Correct include for CGEvent.h


FFI_PLUGIN_EXPORT void pressKeyboardKey(int key)
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

FFI_PLUGIN_EXPORT CGKeyCode keyCodeForChar(const char c)
{
  static CFMutableDictionaryRef charToCodeDict = NULL;
  CGKeyCode code;
  UniChar character = c;
  CFStringRef charStr = NULL;

  /* Generate table of keycodes and characters. */
  if (charToCodeDict == NULL)
  {
    size_t i;
    charToCodeDict = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                               128,
                                               &kCFCopyStringDictionaryKeyCallBacks,
                                               NULL);
    if (charToCodeDict == NULL)
      return UINT16_MAX;

    /* Loop through every keycode (0 - 127) to find its current mapping. */
    for (i = 0; i < 128; ++i)
    {
      CFStringRef string = createStringForKey((CGKeyCode)i);
      if (string != NULL)
      {
        CFDictionaryAddValue(charToCodeDict, string, (const void *)i);
        CFRelease(string);
      }
    }
  }

  charStr = CFStringCreateWithCharacters(kCFAllocatorDefault, &character, 1);

  /* Our values may be NULL (0), so we need to use this function. */
  if (!CFDictionaryGetValueIfPresent(charToCodeDict, charStr,
                                     (const void **)&code))
  {
    code = UINT16_MAX;
  }

  CFRelease(charStr);
  return code;
}