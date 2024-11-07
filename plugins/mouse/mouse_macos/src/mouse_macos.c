#include "mouse_macos.h"
#include <ApplicationServices/ApplicationServices.h>

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

FFI_PLUGIN_EXPORT void mousePressButton(int button)
{
  CGMouseButton mouseButton;
  CGEventType mouseDownEvent;

  // Mapeamento de inteiros para botões do mouse
  switch (button)
  {
  case 0: // Clique esquerdo
    mouseButton = kCGMouseButtonLeft;
    mouseDownEvent = kCGEventLeftMouseDown;
    break;
  case 1: // Clique direito
    mouseButton = kCGMouseButtonRight;
    mouseDownEvent = kCGEventRightMouseDown;
    break;
  case 2: // Clique do meio
    mouseButton = kCGMouseButtonCenter;
    mouseDownEvent = kCGEventOtherMouseDown;
    break;
  default:
    return; // Número inválido, não faz nada
  }

  // Obtém a posição atual do mouse
  CGPoint currentPos = CGEventGetLocation(CGEventCreate(NULL));

  // Cria e envia os eventos de clique
  CGEventRef mouseDown = CGEventCreateMouseEvent(NULL, mouseDownEvent, currentPos, mouseButton);
  CGEventPost(kCGHIDEventTap, mouseDown);
  CFRelease(mouseDown);
}

FFI_PLUGIN_EXPORT void mouseReleaseButton(int button)
{
  CGMouseButton mouseButton;
  CGEventType mouseUpEvent;

  // Mapeamento de inteiros para botões do mouse
  switch (button)
  {
  case 0: // Clique esquerdo
    mouseButton = kCGMouseButtonLeft;
    mouseUpEvent = kCGEventLeftMouseUp;
    break;
  case 1: // Clique direito
    mouseButton = kCGMouseButtonRight;
    mouseUpEvent = kCGEventRightMouseUp;
    break;
  case 2: // Clique do meio
    mouseButton = kCGMouseButtonCenter;
    mouseUpEvent = kCGEventOtherMouseUp;
    break;
  default:
    return; // Número inválido, não faz nada
  }

  // Obtém a posição atual do mouse
  CGPoint currentPos = CGEventGetLocation(CGEventCreate(NULL));

  CGEventRef mouseUp = CGEventCreateMouseEvent(NULL, mouseUpEvent, currentPos, mouseButton);
  CGEventPost(kCGHIDEventTap, mouseUp);
  CFRelease(mouseUp);
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

FFI_PLUGIN_EXPORT void mouseScroll(int x, int y, int amount)
{
  CGEventRef scroll = CGEventCreateScrollWheelEvent(
      NULL, kCGScrollEventUnitPixel, 2, y * amount, x * amount);
  CGEventPost(kCGHIDEventTap, scroll);
  CFRelease(scroll);
}