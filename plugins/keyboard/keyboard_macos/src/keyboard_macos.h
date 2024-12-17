#include <ApplicationServices/ApplicationServices.h>

#define FFI_PLUGIN_EXPORT

/**
 * Sends a key press event to the system.
 *
 * @param key The key code of the key to press.
 */
FFI_PLUGIN_EXPORT void pressKeyboardKey(int key);
/**
 * Sends a key release event to the system.
 *
 * @param key The key code of the key to release.
 */
FFI_PLUGIN_EXPORT void releaseKeyboardKey(int key);


FFI_PLUGIN_EXPORT CGKeyCode keyCodeForChar(const char c);
