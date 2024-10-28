import { mouse, Button, screen, straightTo, Point } from "@nut-tree-fork/nut-js";
import { MiceConfig } from './config';
import { createLogger } from './logger';
import { MiceMoveData, MiceScrollData, } from './mice.d'

const POINTER_SENSITIVITY_DIV = 10;
const SCROLL_SENSITIVITY_DIV = 2;

const logger = createLogger('mice-controller');

let sensitivity: number;
let scrollSensitivity: number;
const screenSize = { width: 0, height: 0 };

let HEIGHT_DIVIDER: number;
let WIDTH_DIVIDER: number;
let allowBruscalMoviments: boolean;

export async function initMice(config: MiceConfig) {
    screenSize.width = await screen.width();
    screenSize.height = await screen.height();

    updateSensitivity(config.defaultSensitivity);
    updateScrollSensitivity(config.defaultScrollSensitivity)

    allowBruscalMoviments = config.allowBruscalMoviments;

    HEIGHT_DIVIDER = config.HEIGHT_DIVIDER;
    WIDTH_DIVIDER = config.WIDTH_DIVIDER;

    logger.info('Configured!')
}

// Função para alterar a sensibilidade do mouse
export const updateSensitivity = (value: number) => {
    sensitivity = value / POINTER_SENSITIVITY_DIV;
    logger.info('Mouse sensitivity set to: ' + sensitivity);
};

export const updateScrollSensitivity = (value: number) => {
    scrollSensitivity = (5 ** ((10 + value) / 10));
    logger.info('Scroll sensitivity set to: ' + scrollSensitivity);
};

// Função para centralizar o cursor
export async function centerCursor() {
    mouse.setPosition(new Point(screenSize.width / 2, screenSize.height / 2))
}

/// Handle simple click
export async function handleClick(type: string) {
    logger.info(`Click: ${type}`)

    let clickType: Button = getButtonFromType(type)

    await mouse.click(clickType)
}

export async function handleDoubleClick(type: string) {
    logger.info(`Click: ${type}`)

    let clickType: Button = getButtonFromType(type)

    await mouse.doubleClick(clickType)
}

function getButtonFromType(type: string) {
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
    return clickType;
}

// Função para mover o cursor
export async function moveCursor(data: MiceMoveData) {
    if (preventBruscalMoviments(data.x, data.y) && !allowBruscalMoviments) return;

    const { x, y } = await checkScreenBoundaries(data.x, data.y);

    await mouse.move([new Point(x, y)]);

    // logger.info(`Cursor moved to (${x}, ${y})`);
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

export function scroll(data: MiceScrollData) {
    logger.info(`Scrolling ${data.direction} | ${scrollSensitivity}`)

    switch (data.direction) {
        case "left":
            return mouse.scrollLeft(scrollSensitivity)
        case "right":
            return mouse.scrollRight(scrollSensitivity)
        case "up":
            return mouse.scrollUp(scrollSensitivity)
        case "down":
            return mouse.scrollDown(scrollSensitivity)
    }
}

export function pressButton(type: string) {
    logger.info(`Button Pressed: ${type}`)

    let clickType: Button = getButtonFromType(type)

    mouse.pressButton(clickType);
}

export function releaseButton(type: string) {
    logger.info(`Button Released: ${type}`)

    let clickType: Button = getButtonFromType(type)

    mouse.releaseButton(clickType);
}