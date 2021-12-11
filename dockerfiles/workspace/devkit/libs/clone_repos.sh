#!/usr/bin/env bash

USER_HOME="/home/workspace"
MOUNT_POINT="/home/workspace/src"

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

clone_repos() {
  cd ${MOUNT_POINT}
  [[ "${DEV_MODE}" == "true" ]] && local dev_arg="-b dev"

  [[ -d portainer-devkit ]] || git clone ${dev_arg} https://github.com/mcpacino/portainer-devkit.git
  [[ -d portainer-ee ]]     || git clone https://$REPLY@github.com/portainer/portainer-ee.git
  [[ -d portainer ]]        || git clone https://github.com/portainer/portainer.git
  [[ -d agent ]]            || git clone https://github.com/portainer/agent.git

  mkdir -p data-ce data-ee

  make_vscode "portainer-ee/.vscode"  "portainer"
  make_vscode "portainer/.vscode"  "portainer"
  make_vscode "agent/.vscode"  "agent"
}
