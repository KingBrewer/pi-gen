#!/bin/bash -e

#Alacarte fixes
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local/share"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local/share/applications"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local/share/desktop-directories"

#opengl fixes
ln -fs /opt/vc/lib/libbrcmGLESv2.so ${ROOTFS_DIR}/opt/vc/lib/libGLESv2.so
ln -fs /opt/vc/lib/libbrcmEGL.so ${ROOTFS_DIR}/opt/vc/lib/libEGL.so
