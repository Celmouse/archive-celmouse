ocument.getElementById('generate-btn').addEventListener('click', async () => {
  const text = document.getElementById('qr-input').value;
  if (text) {
    // Chamar a API exposta pelo preload.js para gerar o QR code
    const qrCodeDataUrl = await window.qrcodeAPI.generateQRCode(text);
    // Exibir o QR code no HTML
    const qrCodeContainer = document.getElementById('qr-code');
    qrCodeContainer.innerHTML = `<img src="${qrCodeDataUrl}" alt="QR Code">`;
  }
});