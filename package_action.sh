#!/bin/bash

set -x 

ARCH=$(dpkg-architecture -qDEB_HOST_ARCH)

if [ ${ARCH} == "amd64" ]; then
    arch="linux-x64"
elif [ ${ARCH} == "arm64" ]; then
    arch="linux-arm64"
elif [ ${ARCH} == "loongarch64" ]; then
    arch="linux-loong64"
else
    echo "Unsupported architecture: ${ARCH}"
    exit 1
fi

if [ -z $1 ]; then
    [ ${ARCH} == "amd64" ] && package_name="electron-v28.2.4-linux-x64.zip"
    [ ${ARCH} == "arm64" ] && package_name="electron-v28.2.4-linux-arm64.zip"
    [ ${ARCH} == "loongarch64" ] && package_name="electron-v26.4.3-linux-loong64.zip"
else
    package_name=$1
fi

#Extract the binary package
if [ ${ARCH} == "amd64" ] || [ ${ARCH} == "arm64" ]; then
    base_name=$(basename ${package_name} .zip)
    unzip src/${ARCH}/${package_name} -d opt/apps/deepin-electron-helper/files/Electron

elif [ ${ARCH} == "loongarch64" ]; then
    base_name=$(basename ${package_name} .zip)
    if [ ! -f "${package_name}" ]; then
        cat ./src/${ARCH}/electron-v26.4.3-${ARCH} > ./${package_name}
    fi
    sha1sum ./${package_name}
    unzip src/${ARCH}/${package_name} -d opt/apps/deepin-electron-helper/files/Electron
fi

#Copy comman files
if [ ${ARCH} == "amd64" ] || [ ${ARCH} == "arm64" ]; then
    cp -r patch/entries opt/apps/deepin-electron-helper/
    cp patch/info opt/apps/deepin-electron-helper/

elif [ ${ARCH} == "loongarch64" ]; then
    mv ./patch/entries opt/apps/deepin-electron-helper/
    mv ./patch/info_loongarch64 opt/apps/deepin-electron-helper/info
fi

#Clean up the environment
rm -fr ${base_name}
exit 0