export interface IElectronAPI {
    setQRCodeIP: (string) => Promise<void>,
}

declare global {
    interface Window {
        electronAPI: IElectronAPI
    }
}