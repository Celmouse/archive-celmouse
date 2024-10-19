import { keyboard } from "@nut-tree-fork/nut-js";
import { MiceConfig } from './config';
import { createLogger } from './logger';

const logger = createLogger('keyboard-controller');


export async function initKeyboard(config: MiceConfig) {
    // TODO: Implement keyboard initial configurations
    keyboard.config = {autoDelayMs: 1}
}

// Função para digitar texto no teclado
export const keyboardType = async (value: string) => {
    await keyboard.type(value);
    logger.info('Keyboard Typing: ' + value);
};