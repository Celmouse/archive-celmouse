/**
 * Sends a key press event to the system.
 *
 * @param keyCode The key code of the key to press.
 */
#define EXPORT __attribute__((visibility("default")))
void pressKeyboardKey(char key);
/**
 * Sends a key release event to the system.
 *
 * @param keyCode The key code of the key to release.
 */
#define EXPORT __attribute__((visibility("default")))
void releaseKeyboardKey(int key);
