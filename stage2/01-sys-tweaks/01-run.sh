#!/bin/bash -e

install -m 755 files/resize2fs_once			${ROOTFS_DIR}/etc/init.d/

install -d						${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d
install -m 644 files/ttyoutput.conf			${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d/

install -m 644 files/50raspi				${ROOTFS_DIR}/etc/apt/apt.conf.d/

install -m 644 files/console-setup   			${ROOTFS_DIR}/etc/default/

install -m 755 files/rc.local				${ROOTFS_DIR}/etc/

on_chroot << EOF
systemctl disable hwclock.sh
systemctl disable nfs-common
systemctl disable rpcbind
systemctl disable ssh
systemctl enable regenerate_ssh_host_keys
systemctl enable resize2fs_once
EOF

on_chroot << \EOF
for GRP in input spi i2c gpio; do
	groupadd -f -r $GRP
done
for GRP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev; do
  adduser pi $GRP
done
EOF

on_chroot << EOF
setupcon --force --save-only -v
EOF

on_chroot << EOF
usermod --pass='*' root
EOF

rm -f ${ROOTFS_DIR}/etc/ssh/ssh_host_*_key*

# opengl fixes
ln -fs /opt/vc/lib/libbrcmGLESv2.so ${ROOTFS_DIR}/opt/vc/lib/libGLESv2.so
ln -fs /opt/vc/lib/libbrcmEGL.so ${ROOTFS_DIR}/opt/vc/lib/libEGL.so
