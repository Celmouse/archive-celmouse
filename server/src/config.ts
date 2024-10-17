import { readFile } from 'fs/promises';

export interface Config {
    port: number;
    defaultSensitivity: number;
    HEIGHT_DIVIDER: number;
    WIDTH_DIVIDER: number;
    allowBruscalMoviments: boolean;
}

export async function loadConfig(): Promise<Config> {
    try {
        const configFile = await readFile('config.json', { encoding: 'utf-8' });
        return JSON.parse(configFile);
    } catch (error) {
        console.warn('Failed to load config file, using defaults:', error);
        return {
            port: 8080,
            defaultSensitivity: 0.5,
            HEIGHT_DIVIDER: 36,
            WIDTH_DIVIDER: 64,
            allowBruscalMoviments: false,
        };
    }
}