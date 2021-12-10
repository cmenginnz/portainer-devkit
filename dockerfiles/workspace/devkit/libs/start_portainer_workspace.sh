#!/usr/bin/env bash

MOUNT_POINT="/home/workspace/src"


download_devkit() {
  [[ "${DEV_MODE}" == "true" ]] && local dev_arg="-b dev"

  cd "${MOUNT_POINT}"

  [[ -d portainer-devkit ]] || git clone ${dev_arg} https://github.com/mcpacino/portainer-devkit.git
}

[[ -z "${PORTAINER_WORKSPACE}" ]] && echo "workspace path PORTAINER_WORKSPACE is not specified" && exit 1

download_devkit

source /devkit/libs/start_sshd.sh
init_workspace

#echo "Start workspace..."

read -p "TEST:  [y/n] " -n 1 -r


${MOUNT_POINT}/portainer-devkit/devkit/scripts/devkit.sh ensure workspace "${PORTAINER_WORKSPACE}"


exit $?