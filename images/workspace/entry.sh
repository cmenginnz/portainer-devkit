#!/usr/bin/env bash

#set -x

# run cmd then exit
[[ ! -z "$@" ]] && exec "$@"


ws="/home/workspace"


init_sshd() {
  # $(ls /etc/ssh/ssh_host_* >/dev/null 2>&1) && return

  mkdir -p /run/sshd

  echo 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitUserEnvironment yes' | augtool -s

  echo "root:root" | chpasswd

  ls /etc/ssh/ssh_host_* >/dev/null 2>&1 || ssh-keygen -A

  # echo StrictHostKeyChecking accept-new >> ~/.ssh/config

  #echo "✅ Initialized sshd"
}

set_agent_env() {
  mkdir -p ~/.ssh
  echo "" > ~/.ssh/environment;
  env | grep KUBERNETES >> ~/.ssh/environment;
  echo StrictHostKeyChecking accept-new >> ~/.ssh/config

  mkdir -p /root/.ssh
  echo "" > /root/.ssh/environment;
  env | grep KUBERNETES >> /root/.ssh/environment;
  echo StrictHostKeyChecking accept-new >> /root/.ssh/config

}

#set_root_password() {
#  #echo ""
#}

set_hosts() {
  echo "192.168.50.1 h00" >> /etc/hosts
}

export I_AM_IN=PORTAINER_WORKSPACE
init_sshd
set_agent_env

cp /fancy_bashrc/bashrc /home/workspace/.bashrc
cp /fancy_bashrc/dir_colors /home/workspace/.dir_colors

/usr/sbin/sshd -e -f /etc/ssh/sshd_config
$OPENVSCODE_SERVER_ROOT/server.sh --port 3000
#/bin/sleep infinity

#set_root_password
#set_hosts

#TODO
# export /home/workspace/go/bin to PATH


# run cmd
#exec "$@"
