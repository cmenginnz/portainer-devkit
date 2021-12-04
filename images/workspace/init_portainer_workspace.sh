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

yesno() {
  local msg="$1"

  read -p "${msg} [y/n] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

_do_download_ee() {
  read -p "Input your github user name to clone portainer-ee: " -r
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
  read -p "Input gitconfig.user.name: " -r
  git config --global user.name "$REPLY"

  read -p "Input gitconfig.user.email: " -r
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

echo "Init workspace..."
init_workspace
