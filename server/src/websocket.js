"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.connectServer = connectServer;
const controller_1 = require("./controller");
const ws_1 = require("ws");
const logger_1 = require("./logger");
const logger = (0, logger_1.createLogger)('websocket');
function connectServer(config) {
    const server = new ws_1.WebSocketServer({ port: config.port });
    logger.info(`WebSocket server running on port ${config.port}`);
    (0, controller_1.initController)(config);
    server.on('connection', ws => {
        console.log('Novo cliente conectado');
        ws.on('message', (data) => handleMessage(data));
        ws.on('close', handleDisconnection);
    });
}
function handleMessage(message) {
    const obj = JSON.parse(message.toString());
    logger.info(`Message received: ${obj.event}`);
    if (obj.changeSensitivityEvent) {
        (0, controller_1.changeSensitivity)(obj.changeSensitivityEvent);
    }
    if (obj.rightClickEvent) {
        (0, controller_1.rightClick)();
    }
    if (obj.leftClickEvent) {
        (0, controller_1.leftClick)();
    }
    if (obj.keyboardTypeEvent) {
        (0, controller_1.keyboardType)(obj.message);
    }
    if (obj.event == "MouseMotionStart") {
        (0, controller_1.centerCursor)();
    }
    if (obj.event == "MouseMotionMove") {
        (0, controller_1.moveCursor)(obj.axis.x, obj.axis.y);
    }
}
function handleDisconnection() {
    logger.info('Cliente desconectado');
}
//# sourceMappingURL=websocket.js.map