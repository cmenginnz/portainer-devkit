#!/usr/bin/env bash

set -x

echo "running entry.sh..."

source libs/init_bashrc.sh
source libs/init_username.sh
source libs/run_command.sh
source libs/start_openvscode.sh
source libs/start_sshd.sh


init_username

run_command $*

start_sshd

init_bashrc

start_openvscode
