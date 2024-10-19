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
exports.keyboardType = void 0;
exports.initKeyboard = initKeyboard;
const nut_js_1 = require("@nut-tree-fork/nut-js");
const logger_1 = require("./logger");
const logger = (0, logger_1.createLogger)('keyboard-controller');
function initKeyboard(config) {
    return __awaiter(this, void 0, void 0, function* () {
        // TODO: Implement keyboard initial configurations
        nut_js_1.keyboard.config = { autoDelayMs: 1 };
    });
}
// Função para digitar texto no teclado
const keyboardType = (value) => __awaiter(void 0, void 0, void 0, function* () {
    yield nut_js_1.keyboard.type(value);
    logger.info('Keyboard Typing: ' + value);
});
exports.keyboardType = keyboardType;
//# sourceMappingURL=keyboard.js.map