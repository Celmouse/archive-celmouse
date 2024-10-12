"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var websocket_1 = require("./src/websocket");
var electron_1 = require("electron");
var path_1 = require("path");
(0, websocket_1.connectServer)();
var createWindow = function () {
    var win = new electron_1.BrowserWindow({
        width: 500,
        height: 600,
        webPreferences: {
            preload: (0, path_1.join)(__dirname, 'preload.js'),
            nodeIntegration: true
        }
    });
    electron_1.ipcMain.on('set-title', function (event, title) {
        var webContents = event.sender;
        var win = electron_1.BrowserWindow.fromWebContents(webContents);
        win.setTitle(title);
    });
    win.loadFile('index.html');
};
electron_1.app.whenReady().then(function () {
    createWindow();
    electron_1.app.on('activate', function () {
        if (electron_1.BrowserWindow.getAllWindows().length === 0) {
            createWindow();
        }
    });
});
electron_1.app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') {
        electron_1.app.quit();
    }
});
//# sourceMappingURL=main.js.map