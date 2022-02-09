#!/usr/bin/env bash

[[ "${DEVKIT_DEBUG}" == "true" ]] &&  set -x

source /entry/libs/init_hosts.sh
source /entry/libs/init_env_var.sh
source /entry/libs/start_sshd.sh
source /entry/libs/init_root_pw.sh

init_hosts
init_root_pw
init_env_var
start_sshd

sleep infinity
