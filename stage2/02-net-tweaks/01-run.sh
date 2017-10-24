#!/bin/bash -e

install -v -d						${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d
install -v -m 644 files/wait.conf			${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/

sed 's/SSID_TOKEN/${WIFI_SSID}/' files/wpa_supplicant.tmpl | sed 's/PSK_TOKEN/${WIFI_PSK}/' > files/wpa_supplicant.conf
install -v -d                                           ${ROOTFS_DIR}/etc/wpa_supplicant
install -v -m 600 files/wpa_supplicant.conf             ${ROOTFS_DIR}/etc/wpa_supplicant/

