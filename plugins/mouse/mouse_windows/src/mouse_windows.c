#include <windows.h>
#include "mouse_windows.h"

void MouseMove(float x, float y) {
  POINT p;
  if (GetCursorPos(&p)) {
    SetCursorPos(p.x + (int)x, p.y + (int)y);
  }
}

void MouseMoveTo(float x, float y) {
  SetCursorPos((int)x, (int)y);
}

void DoubleClick(void) {
  INPUT inputs[4] = {0};

  // First click
  inputs[0].type = INPUT_MOUSE;
  inputs[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

  inputs[1].type = INPUT_MOUSE;
  inputs[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;

  // Second click
  inputs[2].type = INPUT_MOUSE;
  inputs[2].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

  inputs[3].type = INPUT_MOUSE;
  inputs[3].mi.dwFlags = MOUSEEVENTF_LEFTUP;

  SendInput(ARRAYSIZE(inputs), inputs, sizeof(INPUT));
}

void MouseScroll(int x, int y, int amount) {
  INPUT input = {0};
  input.type = INPUT_MOUSE;
  input.mi.dwFlags = MOUSEEVENTF_WHEEL;
  input.mi.mouseData = amount;

  SendInput(1, &input, sizeof(INPUT));
}

void MouseClick(MouseButton button) {
  INPUT inputs[2] = {0};

  inputs[0].type = INPUT_MOUSE;
  inputs[1].type = INPUT_MOUSE;

  switch (button) {
    case kMouseButtonLeft:
      inputs[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
      inputs[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;
      break;
    case kMouseButtonRight:
      inputs[0].mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;
      inputs[1].mi.dwFlags = MOUSEEVENTF_RIGHTUP;
      break;
    case kMouseButtonMiddle:
      inputs[0].mi.dwFlags = MOUSEEVENTF_MIDDLEDOWN;
      inputs[1].mi.dwFlags = MOUSEEVENTF_MIDDLEUP;
      break;
  }

  SendInput(ARRAYSIZE(inputs), inputs, sizeof(INPUT));
}

void MouseHoldLeftButton(void) {
  INPUT input = {0};
  input.type = INPUT_MOUSE;
  input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

  SendInput(1, &input, sizeof(INPUT));
}

void MouseReleaseLeftButton(void) {
  INPUT input = {0};
  input.type = INPUT_MOUSE;
  input.mi.dwFlags = MOUSEEVENTF_LEFTUP;

  SendInput(1, &input, sizeof(INPUT));
}