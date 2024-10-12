// 'use strict'; // Verificar se é necessário
//  require('./src/websocket.js'); // Acessar a função de connectServer
import { connectServer } from './src/websocket';
import { app, BrowserWindow, ipcMain, nativeTheme } from 'electron'
import { join } from 'path';
// import { networkInterfaces } from 'os';
import { QRCode } from 'qrcode';

connectServer();

const createWindow = () => {
  const win = new BrowserWindow({
    width: 500,
    height: 600,
    webPreferences: {
      preload: join(__dirname, 'preload.js'),
      nodeIntegration: true

    }
  })

  ipcMain.on('set-title', (event, title) => {
    const webContents = event.sender
    const win = BrowserWindow.fromWebContents(webContents)
    win.setTitle(title)
  })


  win.loadFile('index.html')
}


app.whenReady().then(() => {
  createWindow()

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) { createWindow() }
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') { app.quit() }
})


