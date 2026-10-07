#!/usr/bin/env bash

set -ex

# needs JDK 25 (jpackage) of the same architecture as the target, run on a Windows host (git bash)
CURL_OPTS="--fail --silent --location"

TOOL_FIXAJFSP="https://github.com/applejuicenetz/tools/releases/latest/download/fixajfsp.exe"
AJCORE_RELEASE_API="https://api.github.com/repos/applejuicenetz/core/releases/latest"
AJGUI_ZIP="https://github.com/applejuicenetz/gui-java/releases/latest/download/AJCoreGUI.zip"
AJCORE_ICO="https://github.com/applejuicenetz/core/raw/main/assets/windows/AJCore.ico"
AJGUI_ICO="https://github.com/applejuicenetz/gui-java/raw/main/assets/windows/AJCoreGUI.ico"

case "${1}" in
amd64 | aarch64)
  BUILD_NAME="appleJuice-Portable-${1}"
  ;;
*)
  echo "unsupported arch, use amd64 or aarch64"
  exit 1
  ;;
esac

JAVA_ARCH=$(java -XshowSettings:properties -version 2>&1 | sed -n 's/^ *os.arch = //p')
case "${JAVA_ARCH}" in
amd64 | x86_64) HOST_ARCH=amd64 ;;
aarch64 | arm64) HOST_ARCH=aarch64 ;;
esac
if [ "${HOST_ARCH}" != "${1}" ]; then
  echo "JDK arch ${JAVA_ARCH} does not match ${1}"
  exit 1
fi

cd "$(dirname "$0")"

AJCORE_JAR=$(curl ${CURL_OPTS} "${AJCORE_RELEASE_API}" |
  python3 -c "import json,sys; print(next(a['browser_download_url'] for a in json.load(sys.stdin)['assets'] if a['name'].endswith('.jar')))")

WORK=.work
rm -rf "${BUILD_NAME}" "${WORK}"
mkdir -p "${BUILD_NAME}" "${WORK}/core-input" "${WORK}/gui-input"

curl ${CURL_OPTS} -o "${WORK}/core-input/ajcore.jar" "${AJCORE_JAR}"
curl ${CURL_OPTS} -o "${WORK}/AJCore.ico" "${AJCORE_ICO}"
curl ${CURL_OPTS} -o "${WORK}/AJCoreGUI.zip" "${AJGUI_ZIP}"
curl ${CURL_OPTS} -o "${WORK}/AJCoreGUI.ico" "${AJGUI_ICO}"
unzip -q "${WORK}/AJCoreGUI.zip" -d "${WORK}/gui-input"
rm -f "${WORK}/gui-input/README.txt"

# portable: user.home is the folder that contains Core and GUI, appleJuice data lands in ./appleJuice
HOME_OPT='-Duser.home=$ROOTDIR/..'

jpackage --type app-image --name Core \
  --dest "${BUILD_NAME}" \
  --input "${WORK}/core-input" \
  --main-jar ajcore.jar \
  --main-class de.applejuicenet.client.core.Core \
  --icon "${WORK}/AJCore.ico" \
  --add-modules java.desktop,java.management,java.naming,java.sql,java.xml,jdk.crypto.ec,jdk.unsupported \
  --java-options --enable-native-access=ALL-UNNAMED \
  --java-options -XX:MaxRAMPercentage=50 \
  --java-options "${HOME_OPT}" \
  --java-options '-XX:ErrorFile=$ROOTDIR/../appleJuice/hs_err_pid%p.log'

# JVM does not create the ErrorFile directory, so it must exist at crash time
mkdir -p "${BUILD_NAME}/appleJuice"

jpackage --type app-image --name GUI \
  --dest "${BUILD_NAME}" \
  --input "${WORK}/gui-input" \
  --main-jar AJCoreGUI.jar \
  --main-class de.applejuicenet.client.AppleJuiceClient \
  --icon "${WORK}/AJCoreGUI.ico" \
  --add-modules java.desktop,java.management,java.naming,java.sql,java.xml,jdk.crypto.ec,jdk.unsupported,jdk.localedata \
  --java-options --enable-native-access=ALL-UNNAMED \
  --java-options "${HOME_OPT}"

curl ${CURL_OPTS} -o "${BUILD_NAME}/fixajfsp.exe" "${TOOL_FIXAJFSP}"

rm -rf "${WORK}"
