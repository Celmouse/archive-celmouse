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
exports.loadConfig = loadConfig;
const promises_1 = require("fs/promises");
function loadConfig() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const configFile = yield (0, promises_1.readFile)('config.json', { encoding: 'utf-8' });
            return JSON.parse(configFile);
        }
        catch (error) {
            console.warn('Failed to load config file, using defaults:', error);
            return {
                mice: {
                    defaultSensitivity: 5,
                    defaultScrollSensitivity: 3,
                    HEIGHT_DIVIDER: 36,
                    WIDTH_DIVIDER: 64,
                    allowBruscalMoviments: false,
                },
                socket: {
                    port: 7771
                },
                keyboard: {}
            };
        }
    });
}
//# sourceMappingURL=config.js.map