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
exports.updateSensitivity = void 0;
exports.initMice = initMice;
exports.centerCursor = centerCursor;
exports.handleClick = handleClick;
exports.handleDoubleClick = handleDoubleClick;
exports.moveCursor = moveCursor;
exports.scroll = scroll;
const nut_js_1 = require("@nut-tree-fork/nut-js");
const logger_1 = require("./logger");
const logger = (0, logger_1.createLogger)('mice-controller');
let sensitivity;
const screenSize = { width: 0, height: 0 };
let HEIGHT_DIVIDER;
let WIDTH_DIVIDER;
let allowBruscalMoviments;
let scrollIntensity = 200;
function initMice(config) {
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
const updateSensitivity = (value) => {
    sensitivity = value;
    logger.info('Mouse delay set to: ' + sensitivity);
};
exports.updateSensitivity = updateSensitivity;
// Função para centralizar o cursor
function centerCursor() {
    return __awaiter(this, void 0, void 0, function* () {
        nut_js_1.mouse.setPosition(new nut_js_1.Point(screenSize.width / 2, screenSize.height / 2));
    });
}
/// Handle simple click
function handleClick(type) {
    return __awaiter(this, void 0, void 0, function* () {
        logger.info(`Click: ${type}`);
        let clickType;
        switch (type) {
            case "right":
                clickType = nut_js_1.Button.RIGHT;
                break;
            case "left":
                clickType = nut_js_1.Button.LEFT;
                break;
            case "middle":
                clickType = nut_js_1.Button.MIDDLE;
                break;
        }
        yield nut_js_1.mouse.click(clickType);
    });
}
function handleDoubleClick(type) {
    return __awaiter(this, void 0, void 0, function* () {
        logger.info(`Click: ${type}`);
        let clickType;
        switch (type) {
            case "right":
                clickType = nut_js_1.Button.RIGHT;
                break;
            case "left":
                clickType = nut_js_1.Button.LEFT;
                break;
            case "middle":
                clickType = nut_js_1.Button.MIDDLE;
                break;
        }
        yield nut_js_1.mouse.doubleClick(clickType);
    });
}
// Função para mover o cursor
function moveCursor(data) {
    return __awaiter(this, void 0, void 0, function* () {
        if (preventBruscalMoviments(data.x, data.y) && !allowBruscalMoviments)
            return;
        const { x, y } = yield checkScreenBoundaries(data.x, data.y);
        yield nut_js_1.mouse.move([new nut_js_1.Point(x, y)]);
        logger.info(`Cursor moved to (${x}, ${y})`);
    });
}
function checkScreenBoundaries(x, y) {
    return __awaiter(this, void 0, void 0, function* () {
        const currentPos = yield nut_js_1.mouse.getPosition();
        let newX = Math.max(0, Math.min(screenSize.width, currentPos.x + x * (WIDTH_DIVIDER * (sensitivity / 10))));
        let newY = Math.max(0, Math.min(screenSize.height, currentPos.y + y * (HEIGHT_DIVIDER * (sensitivity / 10))));
        return { x: newX, y: newY };
    });
}
/// Previne movimentos bruscos ou input estranhos.
function preventBruscalMoviments(x, y) {
    return (x > 8 || x < -8 || y < -8 || y > 8);
}
function scroll(data) {
    logger.info(`Scrolling ${data.direction} | ${data.intensity}`);
    switch (data.direction) {
        case "left":
            return nut_js_1.mouse.scrollLeft(data.intensity);
        case "right":
            return nut_js_1.mouse.scrollRight(data.intensity);
        case "up":
            return nut_js_1.mouse.scrollUp(data.intensity);
        case "down":
            return nut_js_1.mouse.scrollDown(data.intensity);
    }
}
//# sourceMappingURL=mice.js.map