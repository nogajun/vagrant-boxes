# add ssh confguration
echo "UseDNS no" >> /etc/ssh/sshd_config

# Install vagrant keys
SSH_HOME="/home/vagrant/.ssh"
mkdir -p -m 0700 ${SSH_HOME}
wget -O ${SSH_HOME}/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
chmod 0600 ${SSH_HOME}/authorized_keys
chown -R vagrant:vagrant ${SSH_HOME}

# set GRUB_TIMEOUT is none
sed -i '/^GRUB_TIMEOUT/s/[0-9]$/0/g' /etc/default/grub
#sed -i 's/frontend=noninteractive//g' /etc/default/grub
# If use in systemd # sed -i 's/quiet/quiet\ init=\/bin\/systemd/g' /etc/default/grub
/usr/sbin/update-grub
