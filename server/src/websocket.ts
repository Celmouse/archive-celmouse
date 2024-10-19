import { updateSensitivity, moveCursor, centerCursor, initMice, handleClick, handleDoubleClick, scroll, updateScrollSensitivity } from './mice';
import { keyboardType } from './keyboard'
import { WebSocketServer } from 'ws';
import { GlobalConfig, WebSocketConfig } from './config';
import { createLogger } from './logger';
import { ExceptionHandler } from 'winston';

import * as events from './events'

const logger = createLogger('websocket');


export function connectServer(config: GlobalConfig) {
    const server = new WebSocketServer({ port: config.socket.port });

    logger.info(`WebSocket server running on port ${config.socket.port}`);

    initMice(config.mice);

    server.on('connection', ws => {
        console.log('Novo cliente conectado');

        ws.on('message', (data) => handleMessage(data))

        ws.on('close', handleDisconnection);
    });
}

function handleMessage(message: any) {
    const obj: Protocol = JSON.parse(message.toString());
    logger.info(`Message received: ${obj.event}`)

    switch (obj.event) {
        case events.mouseClick:
            /// obj.data can be [ "right", "left", "middle" ]
            return handleClick(obj.data)
        case events.mouseDoubleClick:
            /// obj.data can be [ "right", "left", "middle" ]
            return handleDoubleClick(obj.data)
        case events.changeSensitivity:
            /// obj.data should be a number
            return updateSensitivity(obj.data)
        case events.changeScrollSensitivity:
            /// obj.data should be a number
            return updateScrollSensitivity(obj.data)
        case events.keyPressed:
            /// obj.data should be a list with the keys.
            return keyboardType(obj.data);
        case events.mouseCenter:
            /// obj.data should be null
            return centerCursor()
        case events.mouseMove:
            return moveCursor(obj.data);
        case events.mouseScroll:
            return scroll(obj.data)

    }
}

function handleDisconnection() {
    logger.info('Cliente desconectado');
}