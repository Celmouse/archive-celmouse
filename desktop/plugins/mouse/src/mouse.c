#include "mouse.h"

#if defined(_WIN32) || defined(_WIN64)
#include <windows.h>

FFI_PLUGIN_EXPORT MousePosition get_mouse_position()
{
  MousePosition pos = {0, 0}; // Inicializa a estrutura
  POINT point;
  if (GetCursorPos(&point))
  {
    pos.x = point.x;
    pos.y = point.y;
  }
  return pos;
}

#elif defined(__APPLE__)
#include <ApplicationServices/ApplicationServices.h>
FFI_PLUGIN_EXPORT void move_mouse(int a, int b)
{
  CGEventRef moveEvent = CGEventCreateMouseEvent(
      NULL,
      kCGEventMouseMoved,
      CGPointMake(a, b),
      kCGEventLeftMouseDown);

  CGEventPost(kCGHIDEventTap, moveEvent);
  CFRelease(moveEvent);
}

FFI_PLUGIN_EXPORT MousePosition get_mouse_position()
{
  MousePosition pos = {0, 0}; // Inicializa a estrutura
  CGEventRef event = CGEventCreate(NULL);
  CGPoint cursor = CGEventGetLocation(event);
  double scalingFactor = CGDisplayScreenSize(CGMainDisplayID()).width / CGDisplayPixelsWide(CGMainDisplayID());
  pos.x = (int)(cursor.x * scalingFactor);
  pos.y = (int)(cursor.y * scalingFactor);

  CFRelease(event);
  return pos;
}

#else // Linux com X11
#include <X11/Xlib.h>

FFI_PLUGIN_EXPORT MousePosition get_mouse_position()
{
  MousePosition pos = {0, 0};
  Display *display = XOpenDisplay(NULL);
  if (display)
  {
    Window root = DefaultRootWindow(display);
    Window ret_root, ret_child;
    int root_x, root_y;
    unsigned int mask;
    if (XQueryPointer(display, root, &ret_root, &ret_child, &root_x, &root_y, &pos.x, &pos.y, &mask))
    {
      // Coordenadas capturadas corretamente
    }
    else
    {
      // Se falhar, retorne valores padrão ou mensagem de erro
      pos.x = -1;
      pos.y = -1;
    }
    XCloseDisplay(display);
  }
  else
  {
    pos.x = -1;
    pos.y = -1;
  }
  return pos;
}

#endif