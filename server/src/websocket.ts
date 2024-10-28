import { updateSensitivity, releaseButton, pressButton, moveCursor, centerCursor, initMice, handleClick, handleDoubleClick, scroll, updateScrollSensitivity } from './mice';
import { keyboardType } from './keyboard'
import { WebSocketServer } from 'ws';
import { GlobalConfig, WebSocketConfig } from './config';
import { createLogger } from './logger';
import * as events from './events'
import { BrowserWindow } from 'electron/main';
const logger = createLogger('websocket');


export function startServer(config: GlobalConfig, window: BrowserWindow) {
    const server = new WebSocketServer({ port: config.socket.port });

    logger.info(`WebSocket server running on port ${config.socket.port}`);

    server.on('error', err => {
        console.log(err);
        logger.info(`Connection error: ${err}}`)
    });


    server.on('connection', ws => {
        logger.info('Client connected');

        initMice(config.mice);

        window.webContents.send('connected-client', true)

        ws.on('message', (data) => handleMessage(data))

        ws.on('close', () => {
            window.webContents.send('connected-client', false)

            logger.info('Client disconnected');

        });
    });
}

function handleMessage(message: any) {
    const obj: Protocol = JSON.parse(message.toString());

    switch (obj.event) {
        case events.mouseClick:
            /// obj.data can be [ "right", "left", "middle" ]
            return handleClick(obj.data)
        case events.mouseDoubleClick:
            /// obj.data can be [ "right", "left", "middle" ]
            return handleDoubleClick(obj.data)
        case events.mouseButtonPressed:
            /// obj.data can be [ "right", "left", "middle" ]
            return pressButton(obj.data)
        case events.mouseButtonReleased:
            /// obj.data can be [ "right", "left", "middle" ]
            return releaseButton(obj.data)
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
