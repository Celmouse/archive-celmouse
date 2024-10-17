"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = require("node:path");
const electron_1 = require("electron");
// import { connectServer } from './src/websocket'
function createWindow() {
    const win = new electron_1.BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: (0, node_path_1.join)(__dirname, 'src/preload.js')
        }
    });
    win.loadFile('src/index.html');
}
electron_1.app.whenReady().then(() => {
    createWindow();
    // connectServer();
    electron_1.app.on('activate', () => {
        if (electron_1.BrowserWindow.getAllWindows().length === 0) {
            createWindow();
        }
    });
});
electron_1.app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        electron_1.app.quit();
    }
});
//# sourceMappingURL=main.js.map