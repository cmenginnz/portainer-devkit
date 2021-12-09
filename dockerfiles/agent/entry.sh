#!/usr/bin/env bash

set -x

init_sshd() {
  $(ls /etc/ssh/ssh_ho1st_* >/dev/null 2>&1) && return

  mkdir -p /run/sshd

  echo 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitUserEnvironment yes' | augtool -s

  echo "root:$SSH_PASSWORD" | chpasswd

  ls /etc/ssh/ssh_host_* >/dev/null 2>&1 || ssh-keygen -A

  echo "✅ Initialized sshd"
}

set_agent_env() {
  mkdir -p /root/.ssh
  echo "" > /root/.ssh/environment;

  env | grep KUBERNETES >> /root/.ssh/environment;

  echo "✅ Initialized ssh environment"
}

set_root_password() {
  echo ""
}

set_hosts() {
  echo "192.168.50.1 h00" >> /etc/hosts
}

init_sshd
set_agent_env
set_root_password
set_hosts

# run cmd
exec "$@"
