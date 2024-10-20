"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
console.log('Preload Loaded');
const renderer_1 = require("electron/renderer");
renderer_1.contextBridge.exposeInMainWorld('electronAPI', {
    onUpdateIP: (callback) => renderer_1.ipcRenderer.on('update-ip', (_event, value) => callback(value)),
});
//# sourceMappingURL=preload.js.map