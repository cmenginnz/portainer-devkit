#!/usr/bin/env bash

# this script should run only in Host

# Env Vars:
# PORTAINER_WORKSPACE
# DEV_MODE
# DEVKIT_DEBUG

MOUNT_POINT="/home/workspace/src"

confirm() {
  read -p "Continue with pwd '`pwd`' as workspace?  [y/n] "
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

init_workspace_path() {
  if [[ "${PORTAINER_WORKSPACE}" == "" ]]; then
    if  [[ -d "portainer-devkit" ]] || confirm; then
      PORTAINER_WORKSPACE=$(pwd)
    else
      exit 1
    fi
  fi

  echo "🔹️ Workspace is at $PORTAINER_WORKSPACE"
  [[ ! -z ${DEV_MODE} ]] && echo "🔹️ DEV_MODE=${DEV_MODE}"
}

start_workspace() {
  [[ "${DEV_MODE}" == "true" ]] && local tag=":dev"

  # start the init container to start portainer-workspace container
  docker run --rm -it \
    --name portainer-workspace-init \
    -e "DEV_MODE=${DEV_MODE}" \
    -e "DEVKIT_DEBUG=${DEVKIT_DEBUG}" \
    -e "PORTAINER_WORKSPACE=${PORTAINER_WORKSPACE}" \
    -v "${PORTAINER_WORKSPACE}:${MOUNT_POINT}" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    "mcpacino/portainer-devkit-workspace${tag}" \
    init_portainer_workspace
}

start() {
  init_workspace_path
  start_workspace
  echo && echo "🔹️ vscode is at http://localhost:3000"

	exit $?
}


stop() {
	docker stop portainer-workspace
  exit $?
}


[[ "$1" == "stop" ]] && stop
start
