console.log('Renderer Loaded');

const ipText = document.getElementById('iptext')
const qrImg = document.getElementById('qrcode')
const connectionStatus = document.getElementById('connected')

window.electronAPI.onUpdateQR((qr: string) => {
  qrImg.innerHTML = `<img src=${qr} alt="QR Code" height=200 />`
});

window.electronAPI.onUpdateIPText((ip: string) => {
  ipText.innerText += ip
});

window.electronAPI.onClientConnected((connected: boolean) => {
  connectionStatus.innerText = connected ? "Connected" : "Disconnected"
  connectionStatus.style['color'] = connected ? "green" : "red"
  
})

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