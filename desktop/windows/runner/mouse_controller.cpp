#include <windows.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <map>

class MouseController {
public:
    explicit MouseController(flutter::MethodChannel<flutter::EncodableValue>* channel)
        : channel_(channel) {
        SetupMethodHandlers();
    }

private:
    flutter::MethodChannel<flutter::EncodableValue>* channel_;

    void SetupMethodHandlers() {
        channel_->SetMethodCallHandler([this](const flutter::MethodCall<flutter::EncodableValue>& call,
                                              std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
            const auto* arguments = std::get_if<std::map<std::string, double>>(call.arguments());

            if (call.method_name() == "moveTo") {
                MoveTo((*arguments)["x"], (*arguments)["y"]);
                result->Success();
            } else if (call.method_name() == "move") {
                Move((*arguments)["x"], (*arguments)["y"]);
                result->Success();
            } else if (call.method_name() == "scroll") {
                Scroll((*arguments)["x"], (*arguments)["y"]);
                result->Success();
            } else if (call.method_name() == "click") {
                Click(static_cast<int>((*arguments)["button"]));
                result->Success();
            } else if (call.method_name() == "doubleClick") {
                DoubleClick();
                result->Success();
            } else if (call.method_name() == "holdButton") {
                HoldButton(static_cast<int>((*arguments)["button"]));
                result->Success();
            } else if (call.method_name() == "releaseButton") {
                ReleaseButton(static_cast<int>((*arguments)["button"]));
                result->Success();
            } else {
                result->NotImplemented();
            }
        });
    }

    void MoveTo(double x, double y) {
        SetCursorPos(static_cast<int>(x), static_cast<int>(y));
    }

    void Move(double dx, double dy) {
        POINT cursorPos;
        GetCursorPos(&cursorPos);
        SetCursorPos(cursorPos.x + static_cast<int>(dx), cursorPos.y + static_cast<int>(dy));
    }

    void Scroll(double dx, double dy) {
        INPUT input = {0};
        input.type = INPUT_MOUSE;
        input.mi.dwFlags = MOUSEEVENTF_WHEEL;
        input.mi.mouseData = static_cast<DWORD>(dy * WHEEL_DELTA);
        SendInput(1, &input, sizeof(INPUT));
    }

    void Click(int button) {
        INPUT input[2] = {};
        input[0].type = input[1].type = INPUT_MOUSE;
        if (button == 0) {
            input[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
            input[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;
        } else if (button == 1) {
            input[0].mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;
            input[1].mi.dwFlags = MOUSEEVENTF_RIGHTUP;
        }
        SendInput(2, input, sizeof(INPUT));
    }

    void DoubleClick() {
        Click(0);
        Click(0);
    }

    void HoldButton(int button) {
        INPUT input = {0};
        input.type = INPUT_MOUSE;
        if (button == 0) {
            input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
        } else if (button == 1) {
            input.mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;
        }
        SendInput(1, &input, sizeof(INPUT));
    }

    void ReleaseButton(int button) {
        INPUT input = {0};
        input.type = INPUT_MOUSE;
        if (button == 0) {
            input.mi.dwFlags = MOUSEEVENTF_LEFTUP;
        } else if (button == 1) {
            input.mi.dwFlags = MOUSEEVENTF_RIGHTUP;
        }
        SendInput(1, &input, sizeof(INPUT));
    }
};
