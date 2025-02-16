#include <iostream>
#include "flutter_window.h"
#include <flutter/event_channel.h>
#include <flutter/event_sink.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <flutter/plugin_registrar_windows.h>
#include <Windows.h>
#include <map>
#include <memory>
#include <optional>

#include "flutter/generated_plugin_registrant.h"

FlutterWindow::FlutterWindow(const flutter::DartProject &project)
    : project_(project) {}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate()
{
  if (!Win32Window::OnCreate())
  {
    return false;
  }

  RECT frame = GetClientArea();

  // The size here must match the window dimensions to avoid unnecessary surface
  // creation / destruction in the startup path.
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project_);
  // Ensure that basic setup of the controller was successful.
  if (!flutter_controller_->engine() || !flutter_controller_->view())
  {
    return false;
  }
  RegisterPlugins(flutter_controller_->engine());
  flutter::MethodChannel<> channel(
      flutter_controller_->engine()->messenger(),
      "com.celmouse.plugins/mouse",
      &flutter::StandardMethodCodec::GetInstance());

  channel.SetMethodCallHandler(
      [](const flutter::MethodCall<> &call,
         std::unique_ptr<flutter::MethodResult<>> result)
      {
        // call.arguments()

        if (call.method_name().compare("move") == 0)
        {
          std::cout << "Ta aqui" << std::endl;

          const auto *arguments = std::get_if<flutter::EncodableMap>(call.arguments());
          if (arguments)
          {
            auto dx = std::get<double>(arguments->at(flutter::EncodableValue("x")));
            auto dy = std::get<double>(arguments->at(flutter::EncodableValue("y")));

            // POINT cursorPos;
            // GetCursorPos(&cursorPos);
            // std::cout << "Cursor Position (" << cursorPos.x << ", " << cursorPos.y << ")" << std::endl;
            // SetCursorPos(cursorPos.x + static_cast<int>(dx), cursorPos.y + static_cast<int>(dy));
            ShowCursor(TRUE);
            // mouse_event(MOUSEEVENTF_MOVE, dx, dy, 0, 0);
            INPUT input = {0};
            input.type = INPUT_MOUSE;
            input.mi.dx = static_cast<LONG>(dx);
            input.mi.dy = static_cast<LONG>(dy);
            input.mi.dwFlags = MOUSEEVENTF_MOVE;
            SendInput(1, &input, sizeof(INPUT));
          }
          result->Success();
        }
        if (call.method_name() == "click")
        {
          int button = 0;
          INPUT input[2] = {};
          input[0].type = input[1].type = INPUT_MOUSE;
          if (button == 0)
          {
            input[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
            input[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;
          }
          else if (button == 1)
          {
            input[0].mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;
            input[1].mi.dwFlags = MOUSEEVENTF_RIGHTUP;
          }
          SendInput(2, input, sizeof(INPUT));
        }
      });

  SetChildContent(flutter_controller_->view()->GetNativeWindow());

  flutter_controller_->engine()->SetNextFrameCallback([&]()
                                                      { this->Show(); });

  // Flutter can complete the first frame before the "show window" callback is
  // registered. The following call ensures a frame is pending to ensure the
  // window is shown. It is a no-op if the first frame hasn't completed yet.
  flutter_controller_->ForceRedraw();

  return true;
}

void FlutterWindow::OnDestroy()
{
  if (flutter_controller_)
  {
    flutter_controller_ = nullptr;
  }

  Win32Window::OnDestroy();
}

LRESULT
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              WPARAM const wparam,
                              LPARAM const lparam) noexcept
{
  // Give Flutter, including plugins, an opportunity to handle window messages.
  if (flutter_controller_)
  {
    std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      lparam);
    if (result)
    {
      return *result;
    }
  }

  switch (message)
  {
  case WM_FONTCHANGE:
    flutter_controller_->engine()->ReloadSystemFonts();
    break;
  }

  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}
