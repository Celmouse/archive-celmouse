"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.keyboardType = exports.changeSensitivity = void 0;
exports.configure = configure;
exports.moveCursor = moveCursor;
exports.centerCursor = centerCursor;
exports.rightClick = rightClick;
exports.leftClick = leftClick;
// nutjs-impl.ts
const nut_js_1 = require("@nut-tree-fork/nut-js");
let defaultSensitivity = 10;
const screenSize = { width: 0, height: 0 };
const HEIGHT_DIVIDER = 18;
const WIDTH_DIVIDER = 32;
function configure() {
    return __awaiter(this, void 0, void 0, function* () {
        screenSize.width = yield nut_js_1.screen.width();
        screenSize.height = yield nut_js_1.screen.height();
        console.log('configurado!');
    });
}
// Função para alterar a sensibilidade do mouse
const changeSensitivity = (value) => {
    return;
    defaultSensitivity *= value;
    console.log('Mouse delay set to: ' + defaultSensitivity);
};
exports.changeSensitivity = changeSensitivity;
// Função para digitar texto no teclado
const keyboardType = (value) => __awaiter(void 0, void 0, void 0, function* () {
    // return;
    yield nut_js_1.keyboard.type(value);
    console.log('Keyboard Typing: ' + value);
});
exports.keyboardType = keyboardType;
// Função para mover o cursor
function moveCursor(x, y) {
    return __awaiter(this, void 0, void 0, function* () {
        if (x > 8 || x < -8 || y < -8 || y > 8)
            return;
        const mousePos = yield nut_js_1.mouse.getPosition();
        console.log(`Mouse Motion (${x}, ${y})`);
        const posx = mousePos.x + (screenSize.width / WIDTH_DIVIDER) * x;
        const posy = mousePos.y + (screenSize.height / HEIGHT_DIVIDER) * y;
        console.log(`Cursor moved to (${posx}, ${posy})`);
        yield nut_js_1.mouse.move([new nut_js_1.Point(posx, posy)]);
    });
}
// Função para centralizar o cursor
function centerCursor() {
    return __awaiter(this, void 0, void 0, function* () {
        return;
        const screenSize = { width: yield nut_js_1.screen.width(), height: yield nut_js_1.screen.height() };
        const posx = screenSize.width / 2;
        const posy = screenSize.height / 2;
        yield nut_js_1.mouse.move((0, nut_js_1.straightTo)({ x: posx, y: posy }));
        console.log('Cursor centered to: ' + posx + ', ' + posy);
    });
}
// Função para clicar com o botão direito
function rightClick() {
    return __awaiter(this, void 0, void 0, function* () {
        yield nut_js_1.mouse.click(nut_js_1.Button.RIGHT);
        console.log('Right Click');
    });
}
// Função para clicar com o botão esquerdo
function leftClick() {
    return __awaiter(this, void 0, void 0, function* () {
        yield nut_js_1.mouse.click(nut_js_1.Button.LEFT);
        console.log('Left Click');
    });
}
//# sourceMappingURL=controller.js.map