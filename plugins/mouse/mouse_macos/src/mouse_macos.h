#define FFI_PLUGIN_EXPORT

// Estrutura para armazenar a largura e altura da tela
typedef struct
{
    int width;
    int height;
} ScreenSize;

FFI_PLUGIN_EXPORT void mouseMove(float x, float y);
FFI_PLUGIN_EXPORT void mouseMoveTo(float x, float y);

FFI_PLUGIN_EXPORT ScreenSize getScreenSize(void);

FFI_PLUGIN_EXPORT void performDoubleClick(void);

FFI_PLUGIN_EXPORT void mouseScroll(int x, int y, int amount);

FFI_PLUGIN_EXPORT void mouseClick(int button);
FFI_PLUGIN_EXPORT void mouseHoldLeftButton(void);
FFI_PLUGIN_EXPORT void mouseReleaseLeftButton(void);