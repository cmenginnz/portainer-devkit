#!/usr/bin/env bash

#set -x

make_vscode() {
  VSCODE_PATH=$1

  mkdir -p "$VSCODE_PATH"
  #cd "$VSCODE_PATH"
  ln -f -s \
    ../../portainer-devkit/devkit \
    devkit/vscode/tasks.json \
    devkit/vscode/portainer/launch.json \
    "$VSCODE_PATH"
  #cd -
}

init_workspace() {
  cd /home/workspace

  git clone https://github.com/portainer/portainer.git
  git clone https://github.com/portainer/agent.git
  git clone https://github.com/mcpacino/portainer-devkit.git

  mkdir data-ce
  mkdir data-ee

  make_vscode "portainer/.vscode"
  make_vscode "portainer-ee/.vscode"
  make_vscode "agent/.vscode"

  chown "${USER_UID_GID}" -R portainer agent portainer-devkit data-ce data-ee

  cd -
}


init_sshd() {
  $(ls /etc/ssh/ssh_host_* >/dev/null 2>&1) && return

  mkdir -p /run/sshd

  echo 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' | augtool -s
  echo 'set /files/etc/ssh/sshd_config/PermitUserEnvironment yes' | augtool -s

  echo "root:root" | chpasswd

  ls /etc/ssh/ssh_host_* >/dev/null 2>&1 || ssh-keygen -A

  echo StrictHostKeyChecking accept-new >> ~/.ssh/config

  #echo "✅ Initialized sshd"
}

set_agent_env() {
  mkdir -p /root/.ssh
  echo "" > /root/.ssh/environment;

  env | grep KUBERNETES >> /root/.ssh/environment;

  echo StrictHostKeyChecking accept-new >> ~/.ssh/config

  #echo "✅ Initialized ssh environment"
}

#set_root_password() {
#  #echo ""
#}

set_hosts() {
  echo "192.168.50.1 h00" >> /etc/hosts
}





init_workspace
[[ "$*" == "init" ]] && exit

export I_AM_IN=PORTAINER_DEVKIT
init_sshd
/usr/sbin/sshd -e -f /etc/ssh/sshd_config
$OPENVSCODE_SERVER_ROOT/server.sh --port 3000
#/bin/sleep infinity

#set_agent_env
#set_root_password
#set_hosts

#TODO
# export /home/workspace/go/bin to PATH


# run cmd
#exec "$@"
