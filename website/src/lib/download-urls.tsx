
const winServerVersion = '1.2.0';
const macServerVersion = '1.2.0';
const linuxServerVersion = '1.2.0';
// const appVersion = '1.0.2';

export const downloadUrls = {
  win: `https://celmouse-us.s3.us-east-1.amazonaws.com/Celmouse%2BSetup%2B${winServerVersion}.exe`,
  linux: `https://celmouse-us.s3.us-east-1.amazonaws.com/Celmouse-${linuxServerVersion}.AppImage`,
  macOS: `https://celmouse-us.s3.us-east-1.amazonaws.com/Celmouse-${macServerVersion}.dmg`,
  macOSm1: `https://celmouse-us.s3.us-east-1.amazonaws.com/Celmouse-${macServerVersion}-arm64.dmg`,
  android: "https://play.google.com/store/apps/details?id=com.gyromouse.app",
  ios: "https://apps.apple.com/br/app/gyromouse/id6736866466",
}