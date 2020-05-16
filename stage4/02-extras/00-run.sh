#!/bin/bash -e

#Alacarte fixes
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/applications"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/share/desktop-directories"

# added option to disable screensaver
install -m 644 files/lightdm.conf "${ROOTFS_DIR}/etc/lightdm/lightdm.conf"

# custom sound settings
install -m 644 files/asound.conf "${ROOTFS_DIR}/etc"
install -m 644 files/.asoundrc "${ROOTFS_DIR}/home/pi"

# allow user to control backlight
echo 'SUBSYSTEM=="backlight",RUN+="/bin/chmod 666 /sys/class/backlight/%k/brightness /sys/class/backlight/%k/bl_power"' > "${ROOTFS_DIR}/etc/udev/rules.d/backlight-permissions.rules"
