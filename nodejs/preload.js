import { contextBridge, ipcRenderer } from 'electron';


contextBridge.exposeInMainWorld('qrcodeAPI', {
  generateQRCode: (text) => ipcRenderer.invoke('generate-qr', text)
});