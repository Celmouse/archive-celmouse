export interface IElectronAPI {
    onUpdateQR: (callback: (qr: string) => void) => void;
    onUpdateIPText: (callback: (ip: string) => void) => void;
    onClientConnected: (callback: (connected: boolean) => void) => void;
}

declare global {
    interface Window {
        electronAPI: IElectronAPI
    }
}