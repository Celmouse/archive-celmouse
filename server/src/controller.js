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
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g = Object.create((typeof Iterator === "function" ? Iterator : Object).prototype);
    return g.next = verb(0), g["throw"] = verb(1), g["return"] = verb(2), typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.keyboardType = exports.changeSensitivity = void 0;
exports.configure = configure;
exports.moveCursor = moveCursor;
exports.centerCursor = centerCursor;
exports.rightClick = rightClick;
exports.leftClick = leftClick;
var nut_js_1 = require("@nut-tree-fork/nut-js");
var defaultSensitivity = 10;
var screenSize = { width: 0, height: 0 };
var HEIGHT_DIVIDER = 18;
var WIDTH_DIVIDER = 32;
function configure() {
    return __awaiter(this, void 0, void 0, function () {
        var _a, _b;
        return __generator(this, function (_c) {
            switch (_c.label) {
                case 0:
                    _a = screenSize;
                    return [4, nut_js_1.screen.width()];
                case 1:
                    _a.width = _c.sent();
                    _b = screenSize;
                    return [4, nut_js_1.screen.height()];
                case 2:
                    _b.height = _c.sent();
                    console.log('configurado!');
                    return [2];
            }
        });
    });
}
var changeSensitivity = function (value) {
    return;
    defaultSensitivity *= value;
    console.log('Mouse delay set to: ' + defaultSensitivity);
};
exports.changeSensitivity = changeSensitivity;
var keyboardType = function (value) { return __awaiter(void 0, void 0, void 0, function () {
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0: return [4, nut_js_1.keyboard.type(value)];
            case 1:
                _a.sent();
                console.log('Keyboard Typing: ' + value);
                return [2];
        }
    });
}); };
exports.keyboardType = keyboardType;
function moveCursor(x, y) {
    return __awaiter(this, void 0, void 0, function () {
        var mousePos, posx, posy;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    if (x > 8 || x < -8 || y < -8 || y > 8)
                        return [2];
                    return [4, nut_js_1.mouse.getPosition()];
                case 1:
                    mousePos = _a.sent();
                    console.log("Mouse Motion (".concat(x, ", ").concat(y, ")"));
                    posx = mousePos.x + (screenSize.width / WIDTH_DIVIDER) * x;
                    posy = mousePos.y + (screenSize.height / HEIGHT_DIVIDER) * y;
                    console.log("Cursor moved to (".concat(posx, ", ").concat(posy, ")"));
                    return [4, nut_js_1.mouse.move([new nut_js_1.Point(posx, posy)])];
                case 2:
                    _a.sent();
                    return [2];
            }
        });
    });
}
function centerCursor() {
    return __awaiter(this, void 0, void 0, function () {
        var screenSize, posx, posy;
        var _a;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0: return [2];
                case 1:
                    _a.width = _b.sent();
                    return [4, nut_js_1.screen.height()];
                case 2:
                    screenSize = (_a.height = _b.sent(), _a);
                    posx = screenSize.width / 2;
                    posy = screenSize.height / 2;
                    return [4, nut_js_1.mouse.move((0, nut_js_1.straightTo)({ x: posx, y: posy }))];
                case 3:
                    _b.sent();
                    console.log('Cursor centered to: ' + posx + ', ' + posy);
                    return [2];
            }
        });
    });
}
function rightClick() {
    return __awaiter(this, void 0, void 0, function () {
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4, nut_js_1.mouse.click(nut_js_1.Button.RIGHT)];
                case 1:
                    _a.sent();
                    console.log('Right Click');
                    return [2];
            }
        });
    });
}
function leftClick() {
    return __awaiter(this, void 0, void 0, function () {
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4, nut_js_1.mouse.click(nut_js_1.Button.LEFT)];
                case 1:
                    _a.sent();
                    console.log('Left Click');
                    return [2];
            }
        });
    });
}
//# sourceMappingURL=controller.js.map