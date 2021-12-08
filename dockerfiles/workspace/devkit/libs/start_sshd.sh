#!/usr/bin/env bash

start_sshd() {
  mkdir -p /run/sshd

  echo 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitUserEnvironment yes' | augtool -s

#  echo "root:root" | chpasswd

  ls /etc/ssh/ssh_host_* >/dev/null 2>&1 || ssh-keygen -A

  # echo StrictHostKeyChecking accept-new >> ~/.ssh/config

  #echo "✅ Initialized sshd"
  /usr/sbin/sshd -e -f /etc/ssh/sshd_config

}



#set_agent_env() {
#  mkdir -p ~/.ssh
#  echo "" > ~/.ssh/environment;
#  env | grep KUBERNETES >> ~/.ssh/environment;
#  echo StrictHostKeyChecking accept-new >> ~/.ssh/config
#
#  mkdir -p /root/.ssh
#  echo "" > /root/.ssh/environment;
#  env | grep KUBERNETES >> /root/.ssh/environment;
#  echo StrictHostKeyChecking accept-new >> /root/.ssh/config
#
#}