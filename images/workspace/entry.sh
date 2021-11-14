#!/usr/bin/env bash

#set -x

ws="/home/workspace"


make_vscode() {
  VSCODE_PATH=$1
  PROJECT=$2

  mkdir -p "$VSCODE_PATH"

  ln -f -s \
    ../../portainer-devkit/devkit \
    devkit/vscode/tasks.json \
    "$VSCODE_PATH"

  ln -f -s \
    devkit/vscode/launch.${PROJECT}.json \
    "$VSCODE_PATH/launch.json"
}

download_ee() {
  if [[ ! -d portainer-ee ]]; then
    read -p "Do you want to download portainer-ee? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      read -p "Input your github user name: " -r
      echo
      git clone https://$REPLY@github.com/portainer/portainer-ee.git
    fi
  fi
}

init_workspace() {
  cd ${ws}

  echo "$ ls -l ${ws}"
  ls -l
  echo

  [[ -d portainer ]]        || git clone https://github.com/portainer/portainer.git
  [[ -d agent ]]            || git clone https://github.com/portainer/agent.git
  [[ -d portainer-devkit ]] || git clone https://github.com/mcpacino/portainer-devkit.git
  [[ -d portainer-ee ]]     || download_ee

  [[ -d data-ce ]] || mkdir data-ce
  [[ -d data-ee ]] || mkdir data-ee

  make_vscode "portainer/.vscode"  "portainer"
  make_vscode "agent/.vscode"  "agent"

  [[ -d portainer-ee ]] && make_vscode "portainer-ee/.vscode"  "portainer"

  cd - >/dev/null
}


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



if [ "$*" == "init" ]; then
  echo "init workspace"
  init_workspace
  echo && echo "finished init workspace"
  exit
fi

export I_AM_IN=PORTAINER_WORKSPACE
init_sshd
set_agent_env
/usr/sbin/sshd -e -f /etc/ssh/sshd_config
$OPENVSCODE_SERVER_ROOT/server.sh --port 3000
#/bin/sleep infinity

#set_root_password
#set_hosts

#TODO
# export /home/workspace/go/bin to PATH


# run cmd
#exec "$@"
