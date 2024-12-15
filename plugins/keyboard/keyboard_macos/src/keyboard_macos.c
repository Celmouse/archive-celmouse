#include "keyboard_macos.h"
#include <stdio.h>

#include <ApplicationServices/ApplicationServices.h>

FFI_PLUGIN_EXPORT void pressKeyboardKey(char key)
{
  // Cria os eventos de pressionar e soltar a tecla
  printf("Pressing key %d\n", key);
  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, key, true);

  // Envia o evento de pressionar a tecla
  CGEventPost(kCGHIDEventTap, keyDown);
  CFRelease(keyDown);
}

FFI_PLUGIN_EXPORT void releaseKeyboardKey(int key)
{
  CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, key, false);
  // Envia o evento de soltar a tecla
  CGEventPost(kCGHIDEventTap, keyUp);

  // Libera os eventos criados
  CFRelease(keyUp);
}
