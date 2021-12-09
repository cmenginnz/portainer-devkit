#!/usr/bin/env bash

ws="/home/workspace/devkit"


download_devkit() {
  [[ "${DEV_MODE}" == "true" ]] && local dev_arg="-b dev"

  cd "${ws}"

  [[ -d portainer-devkit ]] || git clone ${dev_arg} https://github.com/mcpacino/portainer-devkit.git
}



[[ -z "${PORTAINER_WORKSPACE}" ]] && echo "workspace path PORTAINER_WORKSPACE is not specified" && exit 1

echo "Start workspace..."
download_devkit
${ws}/portainer-devkit/devkit/scripts/devkit.sh ensure workspace "${PORTAINER_WORKSPACE}"
exit $?
