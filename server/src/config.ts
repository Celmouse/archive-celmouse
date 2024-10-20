import { readFile } from 'fs/promises';

export interface GlobalConfig {
    mice: MiceConfig,
    keyboard: KeyboardConfig,
    socket: WebSocketConfig,
}

export interface WebSocketConfig {
    port: number;
}

export interface MiceConfig {
    defaultSensitivity: number;
    defaultScrollSensitivity: number;
    HEIGHT_DIVIDER: number;
    WIDTH_DIVIDER: number;
    allowBruscalMoviments: boolean;
}

export interface KeyboardConfig {

}

export async function loadConfig(): Promise<(GlobalConfig)> {
    try {
        const configFile = await readFile('config.json', { encoding: 'utf-8' });
        return JSON.parse(configFile);
    } catch (error) {
        console.warn('Failed to load config file, using defaults:', error);
        return {
            mice: {
                defaultSensitivity: 5,
                defaultScrollSensitivity: 3,
                HEIGHT_DIVIDER: 36,
                WIDTH_DIVIDER: 64,
                allowBruscalMoviments: false,
            },
            socket: {
                port: 7771
            },
            keyboard: {
                
            }
        };
    }
}