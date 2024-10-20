export interface IElectronAPI {
    onUpdateQR: (qr) => Promise<void>;
    onUpdateIPText: (ip) => void;
}

declare global {
    interface Window {
        electronAPI: IElectronAPI
    }
}