export interface IElectronAPI {
    onUpdateIP: (string) => Promise<void>,
}

declare global {
    interface Window {
        electronAPI: IElectronAPI
    }
}