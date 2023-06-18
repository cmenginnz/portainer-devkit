#!/usr/bin/env bash

[[ "${DEVKIT_DEBUG}" == "true" ]] &&  set -x

source /entry/libs/start_sshd.sh
source /entry/libs/init_root_pw.sh

init_root_pw
start_sshd

sleep infinity
