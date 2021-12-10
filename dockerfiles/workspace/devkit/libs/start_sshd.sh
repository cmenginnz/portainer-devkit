#!/usr/bin/env bash

start_sshd() {
  mkdir -p /run/sshd

  echo 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitUserEnvironment yes' | augtool -s

  ls /etc/ssh/ssh_host_* >/dev/null 2>&1 || ssh-keygen -A

  /usr/sbin/sshd -e -f /etc/ssh/sshd_config
}
