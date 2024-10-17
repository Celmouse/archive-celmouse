import { changeSensitivity, keyboardType, moveCursor, centerCursor, rightClick, leftClick, configure } from './controller';
import { WebSocketServer } from 'ws';
// const WebSocket = require('ws');


export function connectServer() {
    const server = new WebSocketServer({ port: 8080 });

    console.log('Servidor WebSocket rodando na porta 8080');


    server.on('connection', ws => {
        console.log('Novo cliente conectado');

        configure();

        ws.on('message', message => {

            const obj = JSON.parse(message.toString());

            if (obj.changeSensitivityEvent) {
                changeSensitivity(obj.changeSensitivityEvent);
            }
            if (obj.rightClickEvent) {
                rightClick();
            }
            if (obj.leftClickEvent) {
                leftClick();
            }
            if (obj.keyboardTypeEvent) {
                keyboardType(obj.message);
            }
            if (obj.event == "MouseMotionStart") {
                centerCursor()
            }
            if (obj.event == "MouseMotionMove") {
                moveCursor(obj.axis.x, obj.axis.y);
            }

        });

        ws.on('close', () => {
            console.log('Cliente desconectado');
        });
    });
}