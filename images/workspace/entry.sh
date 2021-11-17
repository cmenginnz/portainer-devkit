#!/usr/bin/env bash

#set -x

ws="/home/workspace"

id


######
# start_portainer_workspace
######

download_devkit() {
  [[ "${DEV_MODE}" == "true" ]] && local dev_arg="-b dev"

  cd "${ws}"

  [[ -d portainer-devkit ]] || git clone ${dev_arg} https://github.com/mcpacino/portainer-devkit.git
}

if [ "$*" == "start_portainer_workspace" ]; then
  [[ -z "${PORTAINER_WORKSPACE}" ]] && echo "workspace path PORTAINER_WORKSPACE is not specified" && exit 1

  echo "Start workspace..."
  download_devkit
  ${ws}/portainer-devkit/devkit/scripts/devkit.sh ensure workspace "${PORTAINER_WORKSPACE}"
  exit $?
fi





######
# init_portainer_workspace
######

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

yesno() {
  local msg="$1"

  read -p "${msg} [y/n] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

_do_download_ee() {
  read -p "Input your github user name: " -r
  echo git clone https://$REPLY@github.com/portainer/portainer-ee.git
  git clone https://$REPLY@github.com/portainer/portainer-ee.git
}

download_ee() {
  if [[ ! -d portainer-ee ]]; then
    local msg="Do you want to download portainer-ee?"
    yesno  "${msg}" && _do_download_ee
  fi
}

_init_git_user() {
  read -p "Input your github user name: " -r
  git config --global user.name "$REPLY"

  read -p "Input your github user email: " -r
  git config --global user.email "$REPLY"
}

init_git() {
  git config --global credential.helper store

  if [[ -z "$(git config --global user.name)" ]] || [[ -z "$(git config --global user.email)" ]]; then
    local msg="Do you want to set user.name and user.email in gitconfig?"
    yesno "$msg" && _init_git_user
  fi
}

clone_repos() {
  [[ "${DEV_MODE}" == "true" ]] && local dev_arg="-b dev"

  [[ -d portainer ]]        || git clone https://github.com/portainer/portainer.git
  [[ -d agent ]]            || git clone https://github.com/portainer/agent.git
  [[ -d portainer-devkit ]] || git clone ${dev_arg} https://github.com/mcpacino/portainer-devkit.git
  [[ -d portainer-ee ]]     || download_ee

  [[ -d data-ce ]] || mkdir data-ce
  [[ -d data-ee ]] || mkdir data-ee

  make_vscode "portainer/.vscode"  "portainer"
  make_vscode "agent/.vscode"  "agent"

  [[ -d portainer-ee ]] && make_vscode "portainer-ee/.vscode"  "portainer"
}

init_workspace() {
  cd ${ws}

  echo "$ ls -l ${ws}"
  ls -l
  echo

  init_git

  clone_repos

  cd - >/dev/null
}

if [ "$*" == "init_portainer_workspace" ]; then
  echo "Init workspace..."
  init_workspace
  exit
fi



######
# normal boot
######

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

cp /fancy_bash/bashrc ~/.bashrc
cp /fancy_bash/dir_colors ~/.dir_colors

/usr/sbin/sshd -e -f /etc/ssh/sshd_config
$OPENVSCODE_SERVER_ROOT/server.sh --port 3000
#/bin/sleep infinity

#set_root_password
#set_hosts

#TODO
# export /home/workspace/go/bin to PATH


# run cmd
#exec "$@"
