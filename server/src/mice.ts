import { mouse, Button, screen, straightTo, Point } from "@nut-tree-fork/nut-js";
import { MiceConfig } from './config';
import { createLogger } from './logger';
import { MiceMoveData, MiceScrollData } from "./mice.i";

const logger = createLogger('mice-controller');

let sensitivity: number;
const screenSize = { width: 0, height: 0 };

let HEIGHT_DIVIDER: number;
let WIDTH_DIVIDER: number;
let allowBruscalMoviments: boolean;

let scrollIntensity: number = 200;

export async function initMice(config: MiceConfig) {
    screenSize.width = await screen.width();
    screenSize.height = await screen.height();

    sensitivity = config.defaultSensitivity;

    allowBruscalMoviments = config.allowBruscalMoviments;
    HEIGHT_DIVIDER = config.HEIGHT_DIVIDER;
    WIDTH_DIVIDER = config.WIDTH_DIVIDER;

    logger.info('configurado!')
}

// Função para alterar a sensibilidade do mouse
export const updateSensitivity = (value: number) => {
    sensitivity = value;
    logger.info('Mouse delay set to: ' + sensitivity);
};



// Função para centralizar o cursor
export async function centerCursor() {
    mouse.setPosition(new Point(screenSize.width / 2, screenSize.height / 2))
}

/// Handle simple click
export async function handleClick(type: string) {
    logger.info(`Click: ${type}`)

    let clickType: Button

    switch (type) {
        case "right":
            clickType = Button.RIGHT
            break;
        case "left":
            clickType = Button.LEFT
            break;
        case "middle":
            clickType = Button.MIDDLE
            break;
    }

    await mouse.click(clickType)
}


export async function handleDoubleClick(type: string) {
    logger.info(`Click: ${type}`)

    let clickType: Button

    switch (type) {
        case "right":
            clickType = Button.RIGHT
            break;
        case "left":
            clickType = Button.LEFT
            break;
        case "middle":
            clickType = Button.MIDDLE
            break;
    }

    await mouse.doubleClick(clickType)
}



// Função para mover o cursor
export async function moveCursor(data: MiceMoveData) {
    if (preventBruscalMoviments(data.x, data.y) && !allowBruscalMoviments) return;

    const { x, y } = await checkScreenBoundaries(data.x, data.y);

    await mouse.move([new Point(x, y)]);

    logger.info(`Cursor moved to (${x}, ${y})`);
}

async function checkScreenBoundaries(x: number, y: number): Promise<{ x: number; y: number; }> {
    const currentPos = await mouse.getPosition();

    let newX = Math.max(0, Math.min(screenSize.width, currentPos.x + x * (WIDTH_DIVIDER * (sensitivity / 10))));
    let newY = Math.max(0, Math.min(screenSize.height, currentPos.y + y * (HEIGHT_DIVIDER * (sensitivity / 10))));

    return { x: newX, y: newY };
}

/// Previne movimentos bruscos ou input estranhos.
function preventBruscalMoviments(x: number, y: number) {
    return (x > 8 || x < -8 || y < -8 || y > 8)
}



export function scroll(data: MiceScrollData) {
    logger.info(`Scrolling ${data.direction} | ${data.intensity}`)

    switch (data.direction) {
        case "left":
            return mouse.scrollLeft(data.intensity)
        case "right":
            return mouse.scrollRight(data.intensity)
        case "up":
            return mouse.scrollUp(data.intensity)
        case "down":
            return mouse.scrollDown(data.intensity)
    }
}