#!/usr/bin/env bash

set -ex

CURL_OPTS="--fail --silent --location"

TOOL_FIXAJFSP="https://github.com/applejuicenetz/tools/releases/latest/download/fixajfsp.exe"

AJCORE_JAR="https://github.com/applejuicenetz/core/releases/latest/download/ajcore.jar"
AJGUI_ZIP="https://github.com/applejuicenetz/gui-java/releases/latest/download/AJCoreGUI.zip"

AJGUI_EXE="https://github.com/applejuicenetz/portable/raw/master/AJCoreGUI.exe"

case "${1}" in
x64)
  # JRE="https://api.adoptopenjdk.net/v3/binary/latest/8/ga/windows/x64/jre/hotspot/normal/adoptopenjdk?project=jdk"
  JRE="https://api.adoptopenjdk.net/v3/binary/version/jdk8u242-b08/windows/x64/jre/hotspot/normal/adoptopenjdk?project=jdk"
  AJNETMASK="https://github.com/applejuicenetz/ajnetmask/releases/latest/download/ajnetmask-x86_64.dll"
  TRAYICON="https://github.com/applejuicenetz/core-trayicon/releases/download/1.0.0/TrayIcon12_x64.dll"
  AJCORE_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/AJCore_x64.exe"
  AJCORE_NOGUI_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/AJCore_x64_nogui.exe"

  BUILD_NAME="appleJuice-Portable-x64"
  ;;

x32)
  JRE="https://api.adoptopenjdk.net/v3/binary/latest/8/ga/windows/x32/jre/hotspot/normal/adoptopenjdk?project=jdk"
  AJNETMASK="https://github.com/applejuicenetz/ajnetmask/releases/latest/download/ajnetmask-i386.dll"
  TRAYICON="https://github.com/applejuicenetz/core-trayicon/releases/download/1.0.0/TrayIcon12_x86.dll"
  AJCORE_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/AJCore_x86.exe"
  AJCORE_NOGUI_EXE="https://github.com/applejuicenetz/portable/raw/master/launcher/AJCore_x86_nogui.exe"

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
curl ${CURL_OPTS} -o ./${BUILD_NAME}/AJCore_nogui.exe ${AJCORE_NOGUI_EXE}

### GUI
curl ${CURL_OPTS} -o ./${BUILD_NAME}/GUI/AJCoreGUI.zip ${AJGUI_ZIP}
unzip ./${BUILD_NAME}/GUI/AJCoreGUI.zip -d ./${BUILD_NAME}/GUI/
rm ./${BUILD_NAME}/GUI/AJCoreGUI.zip ./${BUILD_NAME}/GUI/AJCoreGUI.exe
curl ${CURL_OPTS} -o ./${BUILD_NAME}/AJCoreGUI.exe ${AJGUI_EXE}

### JRE
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Java.zip ${JRE}
unzip ./${BUILD_NAME}/Java.zip -d ./${BUILD_NAME}/Java/
rm ./${BUILD_NAME}/Java.zip
mv ./${BUILD_NAME}/Java/jdk*/* ./${BUILD_NAME}/Java/
rmdir ./${BUILD_NAME}/Java/jdk*/

## create Zip
zip -r ${BUILD_NAME}.zip ${BUILD_NAME}/
shasum -a 256 ${BUILD_NAME}.zip >${BUILD_NAME}.zip.sha256.txt
rm -rf ${BUILD_NAME}
