const { notarize } = require('electron-notarize');
const dotenv = require('dotenv');

dotenv.config();

dotenv.config();

exports.default = async function notarizing(context) {
  const { electronPlatformName, appOutDir } = context;  
  if (electronPlatformName !== 'darwin') {
    return;
  }

  const appName = context.packager.appInfo.productFilename;

  return await notarize({
    tool: 'notarytool',
    teamId: process.env.APPLETEAMID,
    appBundleId: 'com.gyromouse.desktop',
    appPath: `${appOutDir}/${appName}.app`,
    appleId: process.env.APPLEID,
    appleIdPassword: process.env.APPLEIDPASS,
  });
};