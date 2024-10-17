"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.connectServer = connectServer;
const controller_1 = require("./controller");
const ws_1 = require("ws");
// const WebSocket = require('ws');
function connectServer() {
    const server = new ws_1.WebSocketServer({ port: 8080 });
    console.log('Servidor WebSocket rodando na porta 8080');
    server.on('connection', ws => {
        console.log('Novo cliente conectado');
        (0, controller_1.configure)();
        ws.on('message', message => {
            const obj = JSON.parse(message.toString());
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
        });
        ws.on('close', () => {
            console.log('Cliente desconectado');
        });
    });
}
//# sourceMappingURL=websocket.js.map