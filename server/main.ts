import { join } from 'node:path'
import { BrowserWindow, app, globalShortcut } from 'electron'
import * as url from 'url'
import * as path from 'path'
import { startServer } from './src/websocket'
import { loadConfig } from './src/config';



let window: BrowserWindow

function showIp(ip: string) {
  console.log('Teste')
  window.webContents.send('update-ip', 1);
};

async function main() {
  const config = await loadConfig();

  app.whenReady().then(() => {
    createWindow()

    startServer(config);

    app.on('activate', () => {
      if (BrowserWindow.getAllWindows().length === 0) {
        createWindow()
      }
    })
  })

  app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
      app.quit()
    }
  })
}

function createWindow() {
  window = new BrowserWindow({
    title: "CelMouse",
    width: 800,
    height: 600,
    webPreferences: {
      preload: join(__dirname, 'src/app/preload.js')
    }
  })


  window.loadURL(url.format({
    pathname: path.join(__dirname, 'src/app/index.html'),
    protocol: 'file:',
    slashes: true
  }));

  window.webContents.on('did-finish-load', () => {
    const ip = require('my-local-ip')()
    window.webContents.send('update-ip', ip);
  });
}

main().catch(console.error);
