import { join } from 'node:path'
import { BrowserWindow, app } from 'electron'
import { connectServer } from './src/websocket'

// Handle creating/removing shortcuts on Windows when installing/uninstalling.
if (require('electron-squirrel-startup')) {
  app.quit();
}

function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      // sandbox: true,
      preload: join(__dirname, 'preload.js')
    }
  })

  win.loadURL(join(__dirname, 'index.html'))
  win.webContents.openDevTools();
}


app.whenReady().then(() => {
  createWindow()

  connectServer();


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