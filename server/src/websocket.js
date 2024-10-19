"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.connectServer = connectServer;
const mice_1 = require("./mice");
const keyboard_1 = require("./keyboard");
const ws_1 = require("ws");
const logger_1 = require("./logger");
const events = __importStar(require("./events"));
const logger = (0, logger_1.createLogger)('websocket');
function connectServer(config) {
    const server = new ws_1.WebSocketServer({ port: config.socket.port });
    logger.info(`WebSocket server running on port ${config.socket.port}`);
    (0, mice_1.initMice)(config.mice);
    server.on('connection', ws => {
        console.log('Novo cliente conectado');
        ws.on('message', (data) => handleMessage(data));
        ws.on('close', handleDisconnection);
    });
}
function handleMessage(message) {
    const obj = JSON.parse(message.toString());
    logger.info(`Message received: ${obj.event}`);
    switch (obj.event) {
        case events.mouseClick:
            /// obj.data can be [ "right", "left", "middle" ]
            return (0, mice_1.handleClick)(obj.data);
        case events.mouseDoubleClick:
            /// obj.data can be [ "right", "left", "middle" ]
            return (0, mice_1.handleDoubleClick)(obj.data);
        case events.changeSensitivity:
            /// obj.data should be a number
            return (0, mice_1.updateSensitivity)(obj.data);
        case events.changeScrollSensitivity:
            /// obj.data should be a number
            return (0, mice_1.updateScrollSensitivity)(obj.data);
        case events.keyPressed:
            /// obj.data should be a list with the keys.
            return (0, keyboard_1.keyboardType)(obj.data);
        case events.mouseCenter:
            /// obj.data should be null
            return (0, mice_1.centerCursor)();
        case events.mouseMove:
            return (0, mice_1.moveCursor)(obj.data);
        case events.mouseScroll:
            return (0, mice_1.scroll)(obj.data);
    }
}
function handleDisconnection() {
    logger.info('Cliente desconectado');
}
//# sourceMappingURL=websocket.js.map