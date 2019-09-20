# dhcp cleanup
rm /var/lib/dhcp/*
rm /etc/resolv.conf

# cleanup
apt-get -y --purge remove task-japanese xauth
apt-get -y autoremove
apt-get -y clean
for i in $(dpkg -l | grep ^rc | cut -d' ' -f3);do dpkg -P "$i";done

# zeroclear
WORKFILE="/zeroclear"
dd if=/dev/zero of=${WORKFILE} bs=1M
rm -f ${WORKFILE}
