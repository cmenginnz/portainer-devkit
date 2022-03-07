#!/usr/bin/env bash

[[ "${DEVKIT_DEBUG}" == "true" ]] &&  set -x

source /devkit/libs/init_username.sh
source /devkit/libs/start_sshd.sh
source /devkit/libs/init_hosts.sh

init_username
init_hosts

# only for container portainer-workspace-init
if [[ $1 == "init_portainer_workspace" ]]; then
  sudo -u devkit /devkit/libs/init_portainer_workspace.sh
  #sleep infinity
  exit
fi

start_sshd

sudo -u devkit /devkit/libs/init_as_devkit.sh

sleep infinity
