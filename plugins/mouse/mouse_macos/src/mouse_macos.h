#define FFI_PLUGIN_EXPORT

// Estrutura para armazenar a largura e altura da tela
typedef enum
{
    kMouseButtonLeft = 0,
    kMouseButtonRight = 1,
    kMouseButtonMiddle
} MouseButton;

/**
 * @brief Moves the mouse smooth adding x and y accordingly to the current mouse position.
 *
 * If the mouse is in (500, 500) mouseMove(1,1) will move the mouse to (501, 501)
 * This function moves the mouse cursor to the given (x, y) coordinates on the screen.
 *
 * @param x The x-value to add to the move current coordinates.
 * @param y The y-cvalue to add to the move current coordinates.
 */
FFI_PLUGIN_EXPORT void MouseMove(float x, float y);

/**
 * @brief This function moves the mouse cursor to the given (x, y) coordinates on the screen.
 *
 * This function moves the mouse cursor to the given (x, y) coordinates on the screen.
 *
 * @param x The x-coordinate to move the mouse cursor to.
 * @param y The y-coordinate to move the mouse cursor to.
 */
FFI_PLUGIN_EXPORT void MouseMoveTo(float x, float y);

/**
 * @brief This function performs a double click.
 *
 * This function performs a double click with the left mouse button.
 */
FFI_PLUGIN_EXPORT void DoubleClick(void);

/**
 * @brief This function scrolls the mouse wheel.
 *
 * This function scrolls the mouse wheel by a specific pixels amount.
 *
 * @param x The x-value to scroll the mouse wheel.
 * @param y The y-value to scroll the mouse wheel.
 * @param amount The amount of scrolling to perform.
 */
FFI_PLUGIN_EXPORT void MouseScroll(int x, int y, int amount);

/**
 * @brief This function performs a mouse click.
 *
 * This function performs a mouse click with the given button.
 *
 * @param button The button to click.
 */
FFI_PLUGIN_EXPORT void MouseClick(MouseButton button);

/**
 * @brief This function holds the left mouse button.
 *
 * This function holds the left mouse button.
 */
FFI_PLUGIN_EXPORT void MouseHoldLeftButton(void);

/**
 * @brief This function releases the left mouse button.
 *
 * This function releases the left mouse button.
 */
FFI_PLUGIN_EXPORT void MouseReleaseLeftButton(void);