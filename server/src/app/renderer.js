"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const electron_1 = __importDefault(require("electron"));
electron_1.default.globalShortcut.register('CommandOrControl+Shift+K', () => {
    electron_1.default.BrowserWindow.getFocusedWindow().webContents.openDevTools();
});
window.addEventListener('beforeunload', () => {
    electron_1.default.globalShortcut.unregisterAll();
});
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
//# sourceMappingURL=renderer.js.map