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
exports.initController = initController;
exports.moveCursor = moveCursor;
exports.centerCursor = centerCursor;
exports.rightClick = rightClick;
exports.leftClick = leftClick;
// nutjs-impl.ts
const nut_js_1 = require("@nut-tree-fork/nut-js");
const logger_1 = require("./logger");
const logger = (0, logger_1.createLogger)('controller');
let sensitivity;
const screenSize = { width: 0, height: 0 };
let HEIGHT_DIVIDER;
let WIDTH_DIVIDER;
let allowBruscalMoviments;
function initController(config) {
    return __awaiter(this, void 0, void 0, function* () {
        screenSize.width = yield nut_js_1.screen.width();
        screenSize.height = yield nut_js_1.screen.height();
        sensitivity = config.defaultSensitivity;
        allowBruscalMoviments = config.allowBruscalMoviments;
        HEIGHT_DIVIDER = config.HEIGHT_DIVIDER;
        WIDTH_DIVIDER = config.WIDTH_DIVIDER;
        logger.info('configurado!');
    });
}
// Função para alterar a sensibilidade do mouse
const changeSensitivity = (value) => {
    sensitivity = value;
    logger.info('Mouse delay set to: ' + sensitivity);
};
exports.changeSensitivity = changeSensitivity;
// Função para digitar texto no teclado
const keyboardType = (value) => __awaiter(void 0, void 0, void 0, function* () {
    // return;
    yield nut_js_1.keyboard.type(value);
    logger.info('Keyboard Typing: ' + value);
});
exports.keyboardType = keyboardType;
// Função para mover o cursor
function moveCursor(x, y) {
    return __awaiter(this, void 0, void 0, function* () {
        if (preventBruscalMoviments(x, y) && !allowBruscalMoviments)
            return;
        const { x: newX, y: newY } = yield checkScreenBoundaries(x, y);
        yield nut_js_1.mouse.move([new nut_js_1.Point(newX, newY)]);
        logger.info(`Cursor moved to (${newX}, ${newY})`);
    });
}
// Função para centralizar o cursor
function centerCursor() {
    return __awaiter(this, void 0, void 0, function* () {
        nut_js_1.mouse.setPosition(new nut_js_1.Point(screenSize.width / 2, screenSize.height / 2));
    });
}
// Função para clicar com o botão direito
function rightClick() {
    return __awaiter(this, void 0, void 0, function* () {
        yield nut_js_1.mouse.click(nut_js_1.Button.RIGHT);
        logger.info('Right Click');
    });
}
// Função para clicar com o botão esquerdo
function leftClick() {
    return __awaiter(this, void 0, void 0, function* () {
        yield nut_js_1.mouse.click(nut_js_1.Button.LEFT);
        logger.info('Left Click');
    });
}
function checkScreenBoundaries(x, y) {
    return __awaiter(this, void 0, void 0, function* () {
        const currentPos = yield nut_js_1.mouse.getPosition();
        let newX = Math.max(0, Math.min(screenSize.width, currentPos.x + x * (WIDTH_DIVIDER * sensitivity)));
        let newY = Math.max(0, Math.min(screenSize.height, currentPos.y + y * (HEIGHT_DIVIDER * sensitivity)));
        return { x: newX, y: newY };
    });
}
/// Previne movimentos bruscos ou input estranhos.
function preventBruscalMoviments(x, y) {
    return (x > 8 || x < -8 || y < -8 || y > 8);
}
//# sourceMappingURL=controller.js.map