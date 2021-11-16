#!/usr/bin/env bash

# this script should run only in Host

# Env Vars:
# PORTAINER_WORKSPACE
# DEV_MODE

confirm() {
  echo "The workspace path is not specified by env variable PORTAINER_WORKSPACE."
  read -p "Continue within '`pwd`'?  [y/n] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

init_workspace_path() {
  # for mcdebug only
  # [ -d "/home/simon/workspace" ] && [[ "${PORTAINER_WORKSPACE}" == ""  &&  "`hostname`" == "mcdt" ]] && PORTAINER_WORKSPACE="/home/simon/workspace"

  if [[ "${PORTAINER_WORKSPACE}" == "" ]]; then
    if confirm; then
      PORTAINER_WORKSPACE=$(PWD)
    else
      exit 1
    fi
  fi

  echo "Workspace path: $PORTAINER_WORKSPACE in Host"
  echo "DEV_MODE=${DEV_MODE}"
}

init_workspace() {
  [[ "${DEV_MODE}" == "true" ]] && local tag=":dev"

  docker run --rm -it \
    --name portainer-workspace-init \
    --user=`id -u`:`id -g` \
    -e DEV_MODE="${DEV_MODE}" \
    -e PORTAINER_WORKSPACE="${PORTAINER_WORKSPACE}" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    "mcpacino/portainer-devkit-workspace${tag}" \
    start_portainer_workspace
}

init_workspace_path
init_workspace