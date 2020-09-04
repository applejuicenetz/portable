#!/usr/bin/env bash

set -ex

CURL_OPTS="--fail --silent --location"

TOOL_FIXAJFSP="https://github.com/applejuicenet/tools/releases/latest/download/fixajfsp.exe"

AJCORE_JAR="https://github.com/applejuicenet/core/releases/latest/download/ajcore.jar"
AJGUI_ZIP="https://github.com/applejuicenet/gui-java/releases/latest/download/AJCoreGUI.zip"

AJGUI_EXE="https://github.com/applejuicenet/portable/raw/master/AJCoreGUI.exe"

AJCORE_EXE_x86="https://github.com/applejuicenet/portable/raw/master/AJCore_x86.exe"
AJCORE_EXE_x64="https://github.com/applejuicenet/portable/raw/master/AJCore_x64.exe"

AJNETMASK_x86="https://github.com/applejuicenet/ajnetmask/releases/latest/download/ajnetmask-i386.dll"
AJNETMASK_x64="https://github.com/applejuicenet/ajnetmask/releases/latest/download/ajnetmask-x86_64.dll"

TRAYICON_x86="https://github.com/applejuicenet/core-trayicon/releases/download/1.0.0/TrayIcon12_x86.dll"
TRAYICON_x64="https://github.com/applejuicenet/core-trayicon/releases/download/1.0.0/TrayIcon12_x64.dll"

JRE_x86="https://api.adoptopenjdk.net/v2/binary/releases/openjdk8?openjdk_impl=hotspot&os=windows&arch=x32&release=latest&type=jre"
JRE_x64="https://api.adoptopenjdk.net/v2/binary/releases/openjdk8?openjdk_impl=hotspot&os=windows&arch=x64&release=latest&type=jre"

BUILD_NAME_x86="appleJuice-Portable-x86"
BUILD_NAME_x64="appleJuice-Portable-x64"

if [ "$1" = "x64" ]; then
  BUILD_NAME=$BUILD_NAME_x64
  AJNETMASK=$AJNETMASK_x64
  TRAYICON=$TRAYICON_x64
  AJCORE_EXE=$AJCORE_EXE_x64
  JRE=$JRE_x64
else
  BUILD_NAME=$BUILD_NAME_x86
  AJNETMASK=$AJNETMASK_x86
  TRAYICON=$TRAYICON_x86
  AJCORE_EXE=$AJCORE_EXE_x86
  JRE=$JRE_x86
fi

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
shasum -a 256 ${BUILD_NAME}.zip > ${BUILD_NAME}.zip.sha256.txt
rm -rf ${BUILD_NAME}
