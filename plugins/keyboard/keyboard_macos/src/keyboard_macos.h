#define FFI_PLUGIN_EXPORT

/**
 * Sends a key press event to the system.
 *
 * @param keyCode The key code of the key to press.
 */
FFI_PLUGIN_EXPORT void pressKeyboardKey(char key);
/**
 * Sends a key release event to the system.
 *
 * @param keyCode The key code of the key to release.
 */
FFI_PLUGIN_EXPORT void releaseKeyboardKey(int key);
