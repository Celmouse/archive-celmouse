// nutjs-impl.ts
import { mouse, keyboard, Button, screen, straightTo, Point } from "@nut-tree-fork/nut-js";
import { Config } from './config';
import { createLogger } from './logger';

const logger = createLogger('controller');

let sensitivity: number;
const screenSize = { width: 0, height: 0 };

let HEIGHT_DIVIDER: number;
let WIDTH_DIVIDER: number;
let allowBruscalMoviments: boolean;

export async function initController(config: Config) {
    screenSize.width = await screen.width();
    screenSize.height = await screen.height();

    sensitivity = config.defaultSensitivity;

    allowBruscalMoviments = config.allowBruscalMoviments;
    HEIGHT_DIVIDER = config.HEIGHT_DIVIDER;
    WIDTH_DIVIDER = config.WIDTH_DIVIDER;

    logger.info('configurado!')
}

// Função para alterar a sensibilidade do mouse
export const changeSensitivity = (value: number) => {
    sensitivity = value;
    logger.info('Mouse delay set to: ' + sensitivity);
};

// Função para digitar texto no teclado
export const keyboardType = async (value: string) => {
    // return;
    await keyboard.type(value);
    logger.info('Keyboard Typing: ' + value);
};

// Função para mover o cursor
export async function moveCursor(x: number, y: number) {
    if (preventBruscalMoviments(x,y) && !allowBruscalMoviments) return;

    const { x: newX, y: newY } = await checkScreenBoundaries(x, y);

    await mouse.move([new Point(newX, newY)]);
    logger.info(`Cursor moved to (${newX}, ${newY})`);

}

// Função para centralizar o cursor
export async function centerCursor() {
    mouse.setPosition(new Point(screenSize.width / 2, screenSize.height / 2))
}

// Função para clicar com o botão direito
export async function rightClick() {
    await mouse.click(Button.RIGHT);
    logger.info('Right Click');
}

// Função para clicar com o botão esquerdo
export async function leftClick() {
    await mouse.click(Button.LEFT);
    logger.info('Left Click');
}

async function checkScreenBoundaries(x: number, y: number): Promise<{ x: number; y: number; }> {
    const currentPos = await mouse.getPosition();

    let newX = Math.max(0, Math.min(screenSize.width, currentPos.x + x * (WIDTH_DIVIDER * sensitivity)));
    let newY = Math.max(0, Math.min(screenSize.height, currentPos.y + y * (HEIGHT_DIVIDER * sensitivity)));

    return { x: newX, y: newY };
}

/// Previne movimentos bruscos ou input estranhos.
function preventBruscalMoviments(x: number, y: number) {
    return (x > 8 || x < -8 || y < -8 || y > 8)
}