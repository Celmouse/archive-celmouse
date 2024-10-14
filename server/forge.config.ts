import type { ForgeConfig } from '@electron-forge/shared-types';
import { MakerSquirrel } from '@electron-forge/maker-squirrel';
import { MakerZIP } from '@electron-forge/maker-zip';
// import { MakerDeb } from '@electron-forge/maker-deb';
// import { MakerRpm } from '@electron-forge/maker-rpm';
import { MakerPKG } from '@electron-forge/maker-pkg';
// import { MakerDMG } from '@electron-forge/maker-dmg';
import { AutoUnpackNativesPlugin } from '@electron-forge/plugin-auto-unpack-natives';
import { WebpackPlugin } from '@electron-forge/plugin-webpack';
import { FusesPlugin } from '@electron-forge/plugin-fuses';
import { FuseV1Options, FuseVersion } from '@electron/fuses';

import { mainConfig } from './webpack.main.config';
import { rendererConfig } from './webpack.renderer.config';

const config: ForgeConfig = {
  outDir: 'build',
  buildIdentifier: 'v3',
  packagerConfig: {
    appBundleId: 'com.gyromouse.desktop',
    icon: './src/icon/win/',
    extendInfo: './Info.plist',
    // extendInfo: {
    //   'com.apple.security.app-sandbox': true,
    //   'com.apple.security.cs.allow-unsigned-executable-memory': true,
    //   'com.apple.security.cs.disable-library-validation': true,
    //   LSMinimumSystemVersion: '12.0.0',
    //   CFBundleShortVersionString: '1',
    //   'com.apple.security.network.client': true,
    //   'com.apple.security.network.server': true,
    // },
    extendHelperInfo: './Info.child.plist',
    // helperBundleId:  'com.gyromouse.desktop',
    // extendHelperInfo: {
    //   'com.apple.security.app-sandbox': true,
    // 'com.apple.security.inherit': true,
    // },
    appCategoryType: 'public.app-category.utilities',
    asar: true,

  },

  rebuildConfig: {},
  makers: [

    new MakerPKG(
      {
        identity: '3rd Party Mac Developer Installer: Marcelo Fernandes Viana (5NV6KB85G6)'
      }
    ),
    // new MakerSquirrel(
    //   {
    //     exe: 'GyroMouse.exe',
    //     windowsSign: {
    //       certificateFile: './certificates/my-certificate.pfx',
    //       certificatePassword: process.env.WINDOWS_CERTIFICATE_PASSWORD,
    //     }
    //   }
    // ),
    new MakerZIP({}, ['darwin']),

  ],
  plugins: [
    new AutoUnpackNativesPlugin({}),
    new WebpackPlugin({
      mainConfig,
      renderer: {
        config: rendererConfig,
        entryPoints: [
          {
            html: './src/index.html',
            js: './src/renderer.ts',
            name: 'main_window',
            preload: {
              js: './src/preload.ts',
            },
          },
        ],
      },
    }),
    // Fuses are used to enable/disable various Electron functionality
    // at package time, before code signing the application
    new FusesPlugin({
      version: FuseVersion.V1,
      [FuseV1Options.RunAsNode]: false,
      [FuseV1Options.EnableCookieEncryption]: true,
      [FuseV1Options.EnableNodeOptionsEnvironmentVariable]: false,
      [FuseV1Options.EnableNodeCliInspectArguments]: false,
      [FuseV1Options.EnableEmbeddedAsarIntegrityValidation]: true,
      [FuseV1Options.OnlyLoadAppFromAsar]: true,
    }),
  ],
};

export default config;
