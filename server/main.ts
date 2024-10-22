import { join } from 'node:path'
import { BrowserWindow, app, globalShortcut } from 'electron'
import * as url from 'url'
import * as path from 'path'
import { startServer } from './src/websocket'
import { loadConfig } from './src/config';
import { shell } from 'electron/common'



let window: BrowserWindow

function showIp(ip: string) {
  console.log('Teste')
  window.webContents.send('update-ip', 1);
};

async function main() {

  app.whenReady().then(() => {
    createWindow()


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
    title: "Celmouse",
    width: 600,
    height: 600,
    resizable: false,
    webPreferences: {
      preload: join(__dirname, 'src/app/preload.js')
    }
  })

  window.webContents.setWindowOpenHandler(({ url }) => {
    console.log(url)
    shell.openExternal(url);
    return { action: 'deny' };
  })

  window.loadURL(url.format({
    pathname: path.join(__dirname, 'src/app/index.html'),
    protocol: 'file:',
    slashes: true
  }));

  window.webContents.on('did-finish-load', async () => {
    const ip = require('my-local-ip')()
    const qr = await require('qrcode').toDataURL(ip)

    const config = await loadConfig();
    startServer(config, window);

    window.webContents.send('update-ip-text', ip);
    window.webContents.send('update-qr', qr);
  });
}

main().catch(console.error);
