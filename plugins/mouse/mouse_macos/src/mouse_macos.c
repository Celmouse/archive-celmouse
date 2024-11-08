#include "mouse_macos.h"
#include <ApplicationServices/ApplicationServices.h>

FFI_PLUGIN_EXPORT void mouseScroll(int x, int y, int amount)
{
  CGEventRef scroll = CGEventCreateScrollWheelEvent(
      NULL, kCGScrollEventUnitPixel, 2, y * amount, x * amount);
  CGEventPost(kCGHIDEventTap, scroll);
  CFRelease(scroll);
}

FFI_PLUGIN_EXPORT void mouseMove(float x, float y)
{
  // Obter posição atual do mouse
  CGEventRef currentPositionEvent = CGEventCreate(NULL);
  CGPoint currentPos = CGEventGetLocation(currentPositionEvent);
  CFRelease(currentPositionEvent);
  mouseMoveTo(currentPos.x + x, currentPos.y + y);

  // Nova posição com deslocamento
  CGPoint newPos = CGPointMake(currentPos.x + x, currentPos.y + y);

  // Criar evento de movimento para a nova posição
  CGEventRef move = CGEventCreateMouseEvent(
      NULL, kCGEventMouseMoved, newPos, kCGMouseButtonLeft);
  CGEventPost(kCGHIDEventTap, move);
  CFRelease(move);
}

FFI_PLUGIN_EXPORT void mouseMoveTo(float x, float y)
{
  CGPoint newPos = CGPointMake(x, y);

  CGEventRef moveEvent = CGEventCreateMouseEvent(
      NULL,
      kCGEventMouseMoved,
      newPos,
      kCGEventLeftMouseDown);

  CGEventPost(kCGHIDEventTap, moveEvent);
  CFRelease(moveEvent);
}

FFI_PLUGIN_EXPORT ScreenSize getScreenSize(void)
{
  ScreenSize screenSize;

  // Obtenha a tela principal
  CGDirectDisplayID displayId = CGMainDisplayID();

  // Obtenha a largura e a altura da tela principal
  screenSize.width = (int)CGDisplayPixelsWide(displayId);
  screenSize.height = (int)CGDisplayPixelsHigh(displayId);

  return screenSize;
}

FFI_PLUGIN_EXPORT void performDoubleClick(void)
{
  // Obtém a posição atual do mouse
  CGPoint mouseLocation = CGEventGetLocation(CGEventCreate(NULL));

  // Cria o evento de clique duplo
  CGEventRef mouseDoubleClick = CGEventCreateMouseEvent(
      NULL, kCGEventLeftMouseDown, mouseLocation, 0);
  CGEventSetIntegerValueField(mouseDoubleClick, kCGMouseEventClickState, 2);
  CGEventPost(kCGHIDEventTap, mouseDoubleClick);

  CFRelease(mouseDoubleClick);

  // Cria o evento de soltar
  CGEventRef mouseUp = CGEventCreateMouseEvent(
      NULL, kCGEventLeftMouseUp, mouseLocation, 0);
  CGEventPost(kCGHIDEventTap, mouseUp);

  CFRelease(mouseUp);
}

FFI_PLUGIN_EXPORT void mouseClick(int button)
{
  CGPoint mouseLocation = CGEventGetLocation(CGEventCreate(NULL));

  int downEvent = button == 0 ? kCGEventLeftMouseDown : kCGEventRightMouseDown;
  int upEvent = button == 0 ? kCGEventLeftMouseUp : kCGEventRightMouseUp;

  // Cria o evento de clique para pressionar o botão do mouse
  CGEventRef mouseDown = CGEventCreateMouseEvent(
      NULL, downEvent, mouseLocation, button);
  CGEventPost(kCGHIDEventTap, mouseDown);

  // Cria o evento de clique para soltar o botão do mouse
  CGEventRef mouseUp = CGEventCreateMouseEvent(
      NULL, upEvent, mouseLocation, button);
  CGEventPost(kCGHIDEventTap, mouseUp);

  // Libera os eventos
  CFRelease(mouseDown);
  CFRelease(mouseUp);
}

FFI_PLUGIN_EXPORT void mouseHoldLeftButton(void)
{
  // Obtém a posição atual do mouse
  CGPoint currentPos = CGEventGetLocation(CGEventCreate(NULL));

  // Cria e envia os eventos de clique
  CGEventRef mouseDown = NSLeftMouseDragged(NULL, kCGEventLeftMouseDragged, currentPos, 0);
  CGEventPost(kCGHIDEventTap, mouseDown);
  CFRelease(mouseDown);
}

FFI_PLUGIN_EXPORT void mouseReleaseLeftButton(void)
{
  // Obtém a posição atual do mouse
  CGPoint currentPos = CGEventGetLocation(CGEventCreate(NULL));

  CGEventRef mouseUp = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, currentPos, 0);
  CGEventPost(kCGHIDEventTap, mouseUp);
  CFRelease(mouseUp);
}
