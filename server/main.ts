import { join } from 'node:path'
import { BrowserWindow, app, globalShortcut } from 'electron'
import * as url from 'url'
import * as path from 'path'
import { startServer } from './src/websocket'
import { loadConfig } from './src/config';
import { shell } from 'electron/common'
import { createLogger } from './src/logger';

const logger = createLogger("Main")



let window: BrowserWindow

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

  window.loadURL(url.format({
    pathname: path.join(__dirname, 'src/app/index.html'),
    protocol: 'file:',
    slashes: true
  }));

  window.webContents.on('did-finish-load', async () => {
    let ipAddr = require('my-local-ip')()
    var network = require('network');
    
    await network.get_private_ip(function(err: any, ip: any) {
      ipAddr = err || ip; // err may be 'No active network interface found'.
      console.log(ip)
    })
    const qr = await require('qrcode').toDataURL(ipAddr)

    const config = await loadConfig();
    startServer(config, window);

    window.webContents.send('update-ip-text', ipAddr);
    window.webContents.send('update-qr', qr);
  });
}

main().catch((reason) => {
  logger.info(reason);
});
