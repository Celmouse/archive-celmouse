#include "keyboard_macos.h"
#include <stdio.h>

#include <ApplicationServices/ApplicationServices.h>

void pressKeyboardKey(char key)
{
  // Cria os eventos de pressionar e soltar a tecla
  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, key, true);

  // Envia o evento de pressionar a tecla
  CGEventPost(kCGHIDEventTap, keyDown);
  CFRelease(keyDown);
}

void releaseKeyboardKey(int key)
{
  CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, key, false);
  // Envia o evento de soltar a tecla
  CGEventPost(kCGHIDEventTap, keyUp);

  // Libera os eventos criados
  CFRelease(keyUp);
}
