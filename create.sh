#!/usr/bin/env bash

set -ex

CURL_OPTS="--fail --silent --location"

TOOL_FIXAJFSP="https://github.com/applejuicenetz/tools/releases/latest/download/fixajfsp.exe"

AJCORE_JAR="https://github.com/applejuicenetz/core/releases/latest/download/ajcore.jar"
AJGUI_ZIP="https://github.com/applejuicenetz/gui-java/releases/latest/download/AJCoreGUI.zip"

AJGUI_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/gui/AJCoreGUI.exe"

case "${1}" in
x64)
  JRE_CORE="https://github.com/applejuicenetz/zulu-jre7/releases/latest/download/jre7.x64.zip"
  AJNETMASK="https://github.com/applejuicenetz/ajnetmask/releases/latest/download/ajnetmask-x86_64.dll"
  TRAYICON="https://github.com/applejuicenetz/core-trayicon/releases/latest/download/TrayIcon12_x64.dll"
  AJCORE_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/core/AJCore_x64.exe"
  JRE_GUI="https://api.adoptium.net/v3/binary/latest/11/ga/windows/x64/jre/hotspot/normal/eclipse?project=jdk"
  BUILD_NAME="appleJuice-Portable-x64"
  ;;

x86)
  JRE_CORE="https://github.com/applejuicenetz/zulu-jre7/releases/latest/download/jre7.x86.zip"
  AJNETMASK="https://github.com/applejuicenetz/ajnetmask/releases/latest/download/ajnetmask-i386.dll"
  TRAYICON="https://github.com/applejuicenetz/core-trayicon/releases/latest/download/TrayIcon12_x86.dll"
  AJCORE_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/core/AJCore_x86.exe"
  JRE_GUI="https://api.adoptium.net/v3/binary/latest/11/ga/windows/x86/jre/hotspot/normal/eclipse?project=jdk"
  BUILD_NAME="appleJuice-Portable-x86"
  ;;

*)
  echo "unsupported arch"
  exit 1
  ;;
esac

cd $(dirname $0)

# prepare
rm -rf ${BUILD_NAME}
mkdir -p ${BUILD_NAME}/Core
mkdir -p ${BUILD_NAME}/GUI

#### ship also fixajfsp
curl ${CURL_OPTS} -o ./${BUILD_NAME}/fixajfsp.exe ${TOOL_FIXAJFSP}

#### Core
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/ajcore.jar ${AJCORE_JAR}
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/ajnetmask.dll ${AJNETMASK}
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/TrayIcon12.dll ${TRAYICON}
curl ${CURL_OPTS} -o ./${BUILD_NAME}/AJCore.exe ${AJCORE_EXE}

### JRE Core
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/Java.zip ${JRE_CORE}
unzip ./${BUILD_NAME}/Core/Java.zip -d ./${BUILD_NAME}/Core/
rm ./${BUILD_NAME}/Core/Java.zip

### GUI
curl ${CURL_OPTS} -o ./${BUILD_NAME}/GUI/AJCoreGUI.zip ${AJGUI_ZIP}
unzip ./${BUILD_NAME}/GUI/AJCoreGUI.zip -d ./${BUILD_NAME}/GUI/
rm ./${BUILD_NAME}/GUI/AJCoreGUI.zip ./${BUILD_NAME}/GUI/AJCoreGUI.exe
curl ${CURL_OPTS} -o ./${BUILD_NAME}/AJCoreGUI.exe ${AJGUI_EXE}

### JRE Core
curl ${CURL_OPTS} -o ./${BUILD_NAME}/GUI/Java.zip ${JRE_GUI}
unzip ./${BUILD_NAME}/GUI/Java.zip -d ./${BUILD_NAME}/GUI/Java/
rm ./${BUILD_NAME}/GUI/Java.zip
mv ./${BUILD_NAME}/GUI/Java/jdk*/* ./${BUILD_NAME}/GUI/Java/
rmdir ./${BUILD_NAME}/GUI/Java/jdk*/

## create Zip
zip -r ${BUILD_NAME}.zip ${BUILD_NAME}/
shasum -a 256 ${BUILD_NAME}.zip >${BUILD_NAME}.zip.sha256.txt
rm -rf ${BUILD_NAME}/
