import { join } from 'node:path'
import { BrowserWindow, app } from 'electron'
// import { connectServer } from './src/websocket'


function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: join(__dirname, 'src/preload.js')
    }
  })

  win.loadFile('src/index.html')
}


app.whenReady().then(() => {
  createWindow()

  // connectServer();


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