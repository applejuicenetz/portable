#!/usr/bin/env bash

VERSION_GUI="0.80.0"
VERSION_CORE="0.31.149.110"
VERSION_JRE_X86="java-1.8.0-openjdk-jre-1.8.0.265-1.b01.ojdkbuild.windows.x86.zip"
VERSION_JRE_X64="java-1.8.0-openjdk-jre-1.8.0.262-1.b10.ojdkbuild.windows.x86_64.zip"

cd $(dirname $0)

rm -rf build

mkdir -p build/Core
mkdir -p build/GUI

### Core
# curl -o ./build/Core/ajcore.jar https://github.com/applejuicenet/core/releases/download/${VERSION_CORE}/ajcore.jar
# TODO download ajnetmask.dll for each architecture
# TODO download Trayicon12.dll for each architecture
# TODO copy our AJCore.exe to build folder

### GUI
# curl -o ./build/GUI/AjcoreGUI.zip https://github.com/applejuicenet/gui-java/releases/download/${VERSION_GUI}/AJCoreGUI.zip
# TODO extract AJcoreGUI.zip to current folder
# TODO remove original "AJcoreGUI.exe"
# TODO copy our AJCoreGUI.exe to build folder

### JRE
# TODO download JRE for each architecture and place it in "Java" Folder


### ZIP
# TODO compress everything


