#!/bin/bash -x
#
# https://tutorials.ubuntu.com/tutorial/create-custom-lxd-images
#

DIST="debian"
RELEASE="buster"
DEB_ARCH="amd64"
ARCH="x86_64"
MIRROR="http://deb.debian.org/debian/"
DESC="Debian 10 Buster Vanilla Image"

# ----------

rootfs(){
  WORK=$(mktemp -d -p /tmp/)
  ROOTFS="rootfs.tar.gz"
  sudo /usr/sbin/debootstrap --arch ${DEB_ARCH} ${RELEASE} ${WORK}/ ${MIRROR} 
  sudo sed -e 's/main$/main contrib non-free/g' ${WORK}/etc/apt/sources.list
  sudo tar cvfz ${ROOTFS} -C ${WORK} .
  [ -f ${ROOTFS} -a -d ${WORK} ] && sudo rm -rf ${WORK}/
}

metadata(){
  METADATA="metadata.yaml"
  cat <<_EOL_ > ${METADATA}
architecture: "${ARCH}"
creation_date: $(date +%s)
properties:
architecture: "${ARCH}"
description: "${DESC}"
os: "${DIST}"
release: "${RELEASE}"
_EOL_
  [ -f ${METADATA} ] && tar cvzf metadata.tar.gz ${METADATA} && rm ${METADATA}
}

rootfs
metadata


