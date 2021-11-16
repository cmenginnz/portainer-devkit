#!/usr/bin/env bash

# this script should run only in Host

confirm() {
  echo "The workspace is not specifyed by Environment variable PORTAINER_WORKSPACE."
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

  echo "PORTAINER_WORKSPACE=$PORTAINER_WORKSPACE in Host"
}

init_workspace() {
  docker run --rm -it \
    --name portainer-workspace-init \
    --user=`id -u`:`id -g` \
    -v "${PORTAINER_WORKSPACE}":/home/workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    mcpacino/portainer-devkit-workspace:dev \
    init
}

ensure_workspace() {
  ${PORTAINER_WORKSPACE}/portainer-devkit/devkit/scripts/devkit.sh ensure network &&
  ${PORTAINER_WORKSPACE}/portainer-devkit/devkit/scripts/devkit.sh ensure workspace
}

init_workspace_path
init_workspace
ensure_workspace
