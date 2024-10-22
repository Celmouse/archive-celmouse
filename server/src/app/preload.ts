console.log('Preload Loaded');

import { contextBridge, ipcRenderer } from 'electron/renderer'

contextBridge.exposeInMainWorld('electronAPI', {
  onClientConnected: (callback: (connected: boolean) => void) => ipcRenderer.on('connected-client', (_event, value) => {
    console.log("Entrou")
    return callback(value)
  } ),
  onUpdateQR: (callback: (qr: any) => void) => ipcRenderer.on('update-qr', (_event, value) => callback(value)),
  onUpdateIPText: (callback: (ip: string) => void) => ipcRenderer.on('update-ip-text', (_event, value) => callback(value)),
})