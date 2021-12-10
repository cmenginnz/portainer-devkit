#!/usr/bin/env bash

set -x

echo "running entry.sh..."

source libs/init_bashrc.sh
source libs/init_username.sh
source libs/run_command.sh
source libs/start_openvscode.sh
source libs/start_sshd.sh

init_username

if [[ $1 == "start_portainer_workspace" ]]; then
  sudo -u devkit /devkit/libs/start_portainer_workspace.sh
  exit
fi


#sudo -u devkit /devkit/libs/ init_as_devkit

init_ssh

start_sshd

init_bashrc

start_openvscode

sleep infinity