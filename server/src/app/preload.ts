console.log('Preload Loaded');

import { contextBridge, ipcRenderer } from 'electron/renderer'

contextBridge.exposeInMainWorld('electronAPI', {
  onUpdateIP: (callback: (ip: string) => void) => ipcRenderer.on('update-ip', (_event, value) => callback(value)),
})