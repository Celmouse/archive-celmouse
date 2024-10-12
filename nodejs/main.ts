// 'use strict'; // Verificar se é necessário
//  require('./src/websocket.js'); // Acessar a função de connectServer
import { connectServer } from './src/websocket';
import { app, BrowserWindow, ipcMain } from 'electron'
import { join } from 'path';
// import { networkInterfaces } from 'os';
import { QRCode } from 'qrcode';

connectServer();

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false
    }
  })

  win.loadFile('index.html')
}

// app.whenReady().then(() => {
//     createWindow()
// })

app.whenReady().then(() => {
  createWindow()

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit()
})


