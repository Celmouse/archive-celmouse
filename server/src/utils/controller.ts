// nutjs-impl.ts
import { mouse, keyboard, Button, screen, straightTo, Point } from "@nut-tree-fork/nut-js";

let defaultSensitivity = 10;
const screenSize = { width: 0, height: 0 };

const HEIGHT_DIVIDER = 18;
const WIDTH_DIVIDER = 32;

export async function configure() {
    screenSize.width = await screen.width();
    screenSize.height = await screen.height();
    console.log('configurado!')
}

// Função para alterar a sensibilidade do mouse
export const changeSensitivity = (value: number) => {
    return;
    defaultSensitivity *= value;
    console.log('Mouse delay set to: ' + defaultSensitivity);
};

// Função para digitar texto no teclado
export const keyboardType = async (value: string) => {
    return;
    await keyboard.type(value);
    console.log('Keyboard Typing: ' + value);
};

// Função para mover o cursor
export async function moveCursor(x: number, y: number) {
    if (x > 8 || x < -8 || y < -8 || y > 8) return;
    const mousePos = await mouse.getPosition();

    console.log(`Mouse Motion (${x}, ${y})`);

    const posx = mousePos.x + (screenSize.width / WIDTH_DIVIDER) * x;
    const posy = mousePos.y + (screenSize.height / HEIGHT_DIVIDER) * y;

    console.log(`Cursor moved to (${posx}, ${posy})`);

    await mouse.move([new Point(posx, posy)]);
}

// Função para centralizar o cursor
export async function centerCursor() {
    return;
    const screenSize = { width: await screen.width(), height: await screen.height() };
    const posx = screenSize.width / 2;
    const posy = screenSize.height / 2;

    await mouse.move(straightTo({ x: posx, y: posy }));
    console.log('Cursor centered to: ' + posx + ', ' + posy);
}

// Função para clicar com o botão direito
export async function rightClick() {
    await mouse.click(Button.RIGHT);
    console.log('Right Click');
}

// Função para clicar com o botão esquerdo
export async function leftClick() {
    await mouse.click(Button.LEFT);
    console.log('Left Click');
}