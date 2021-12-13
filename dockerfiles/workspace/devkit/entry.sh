#!/usr/bin/env bash

[[ "${DEVKIT_DEBUG}" == "true" ]] &&  set -x

source libs/init_username.sh
source libs/start_sshd.sh

init_username

# only for container portainer-workspace-init
if [[ $1 == "init_portainer_workspace" ]]; then
  sudo -u devkit /devkit/libs/init_portainer_workspace.sh
  exit
fi

start_sshd

sudo -u devkit /devkit/libs/init_as_devkit.sh

sleep infinity