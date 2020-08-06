#!/usr/bin/env bash

set -e

BUILD_NAME="appleJuice-Portable-x86"
CURL_OPTS="--fail --silent --location"

cd $(dirname $0)

# prepare
rm -rf ${BUILD_NAME}
mkdir -p ${BUILD_NAME}/Core
mkdir -p ${BUILD_NAME}/GUI

#### ship also fixajfsp
curl ${CURL_OPTS} -o ./${BUILD_NAME}/fixajfsp.exe https://github.com/applejuicenet/tools/releases/latest/download/fixajfsp.exe

#### Core
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/ajcore.jar https://github.com/applejuicenet/core/releases/latest/download/ajcore.jar
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/ajnetmask.dll https://github.com/applejuicenet/ajnetmask/releases/latest/download/ajnetmask-i386.dll
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Core/TrayIcon12.dll https://github.com/applejuicenet/core/releases/download/0.31.149.110/TrayIcon12_i386.dll
cp ./AJCore_x86.exe ./${BUILD_NAME}/AJCore.exe

### GUI
curl ${CURL_OPTS} -o ./${BUILD_NAME}/GUI/AJCoreGUI.zip https://github.com/applejuicenet/gui-java/releases/latest/download/AJCoreGUI.zip
unzip ./${BUILD_NAME}/GUI/AJCoreGUI.zip -d ./${BUILD_NAME}/GUI/
rm ./${BUILD_NAME}/GUI/AJCoreGUI.zip ./${BUILD_NAME}/GUI/AJCoreGUI.exe
cp ./AJCoreGUI.exe ./${BUILD_NAME}/

### JRE
curl ${CURL_OPTS} -o ./${BUILD_NAME}/Java.zip "https://api.adoptopenjdk.net/v2/binary/releases/openjdk8?openjdk_impl=hotspot&os=windows&arch=x32&release=latest&type=jre"
unzip ./${BUILD_NAME}/Java.zip -d ./${BUILD_NAME}/Java/
rm ./${BUILD_NAME}/Java.zip
mv ./${BUILD_NAME}/Java/jdk*/* ./${BUILD_NAME}/Java/
rmdir ./${BUILD_NAME}/Java/jdk*/

## create Zip
zip -r ${BUILD_NAME}.zip ${BUILD_NAME}/
md5 ${BUILD_NAME}.zip > ${BUILD_NAME}.zip.md5.txt
shasum -a 256 ${BUILD_NAME}.zip > ${BUILD_NAME}.zip.sha265.txt
rm -rf ${BUILD_NAME}
