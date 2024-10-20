console.log('Preload Loaded');

import { contextBridge, ipcRenderer } from 'electron/renderer'

contextBridge.exposeInMainWorld('electronAPI', {
  onUpdateQR: (callback: (qr: any) => void) => ipcRenderer.on('update-qr', (_event, value) => callback(value)),
  onUpdateIPText: (callback: (ip: string) => void) => ipcRenderer.on('update-ip-text', (_event, value) => callback(value)),
})