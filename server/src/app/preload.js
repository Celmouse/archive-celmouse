const { contextBridge, ipcRenderer } = require('electron/renderer');
contextBridge.exposeInMainWorld('electronAPI', {
    onUpdateIP: (callback) => ipcRenderer.on('update-ip', (_event, value) => callback(value)),
});
//# sourceMappingURL=preload.js.map