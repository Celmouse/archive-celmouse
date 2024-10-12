// const { getIp } = require('/src/utils/ifconfig.ts')


const setButton = document.getElementById('btn')
const titleInput = document.getElementById('title')

setButton?.addEventListener('click', () => {
  const title = titleInput?.value;

  // const ip = getIp();
  window.electronAPI.setTitle(ip)
})