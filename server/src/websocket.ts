import { updateSensitivity, moveCursor, centerCursor, initMice, handleClick, handleDoubleClick, scroll, updateScrollSensitivity } from './mice';
import { keyboardType } from './keyboard'
import { WebSocketServer } from 'ws';
import { GlobalConfig, WebSocketConfig } from './config';
import { createLogger } from './logger';
import * as events from './events'
const logger = createLogger('websocket');


export function startServer(config: GlobalConfig) {
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


// <script>
//     function generateBarCode() {
//       // var nric = $('#text').val();
//       var nric = '192.168.52.102';
//       var url = 'https://api.qrserver.com/v1/create-qr-code/?data=' + nric + '&amp;size=450x450';
//       $('#barcode').attr('src', url);
//     }
//   </script>
// */

// <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

// <!-- <input id="text" type="text" value="NRIC or Work Permit" style="Width:20%" onblur='generateBarCode();' /> -->

// <img id='barcode' src="https://api.qrserver.com/v1/create-qr-code/?data=192.168.52.102&amp;size=450x450" alt=""
//   title="QR Code" width="450" height="450" />