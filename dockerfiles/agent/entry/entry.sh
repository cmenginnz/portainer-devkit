#!/usr/bin/env bash

[[ "${DEVKIT_DEBUG}" == "true" ]] &&  set -x

source /entry/libs/init_root_pw.sh
source /entry/libs/start_sshd.sh
source /entry/libs/init_env_var.sh

init_root_pw
start_sshd
init_env_var

sleep infinity
