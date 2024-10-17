import { changeSensitivity, keyboardType, moveCursor, centerCursor, rightClick, leftClick, initController } from './controller';
import { WebSocketServer } from 'ws';
import { Config } from './config';
import { createLogger } from './logger';
import { ExceptionHandler } from 'winston';

const logger = createLogger('websocket');


export function connectServer(config: Config) {
    const server = new WebSocketServer({ port: config.port });
    
    logger.info(`WebSocket server running on port ${config.port}`);
    
    initController(config);

    server.on('connection', ws => {
        console.log('Novo cliente conectado');

        ws.on('message', (data)=> handleMessage(data))

        ws.on('close', handleDisconnection);
    });
}

function handleMessage(message: any) {
    const obj = JSON.parse(message.toString());
    logger.info(`Message received: ${obj.event}`)

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
}

function handleDisconnection(){
    logger.info('Cliente desconectado');
}