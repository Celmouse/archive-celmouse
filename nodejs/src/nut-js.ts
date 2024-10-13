// nutjs-impl.ts
import { mouse, keyboard, Button, Key, screen, straightTo, centerOf } from "@nut-tree-fork/nut-js";

let defaultSensitivity = 10;

// Função para alterar a sensibilidade do mouse
export const changeSensitivity = (value: number) => {
    defaultSensitivity *= value;
    console.log('Mouse delay set to: ' + value);
};

// Função para digitar texto no teclado
export const keyboardType = async (value: string) => {
    await keyboard.type(value);
    console.log('Keyboard Typing: ' + value);
};

// Função para mover o cursor
export async function moveCursor(x: number, y: number) {
    const screenSize = await screen.width();
    const mousePos = await mouse.getPosition();

    console.log(`Mouse Motion (${x}, ${y})`);

    const posx = mousePos.x + (screenSize / 32) * x;
    const posy = mousePos.y + (screenSize / 18) * y;

    await mouse.move(straightTo({ x: posx, y: posy }));
    console.log('Cursor moved to: ' + posx + ', ' + posy);
};

// Função para centralizar o cursor
export async function centerCursor() {
    const screenSize = { width: await screen.width(), height: await screen.height() };
    const posx = screenSize.width / 2;
    const posy = screenSize.height / 2;

    await mouse.move(straightTo({ x: posx, y: posy }));
    console.log('Cursor centered to: ' + posx + ', ' + posy);
};

// Função para clicar com o botão direito
export async function rightClick() {
    await mouse.click(Button.RIGHT);
    console.log('Right Click');
};

// Função para clicar com o botão esquerdo
export async function leftClick() {
    await mouse.click(Button.LEFT);
    console.log('Left Click');
};