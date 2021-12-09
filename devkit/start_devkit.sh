#!/usr/bin/env bash
set -x

# this script should run only in Host

# Env Vars:
# PORTAINER_WORKSPACE
# DEV_MODE
# DEVKIT_DEBUG

confirm() {
  read -p "Continue with pwd '`pwd`' as workspace?  [y/n] "
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

init_workspace_path() {
  # for mcdebug only
  # [ -d "/home/simon/workspace" ] && [[ "${PORTAINER_WORKSPACE}" == ""  &&  "`hostname`" == "mcdt" ]] && PORTAINER_WORKSPACE="/home/simon/workspace"

  if [[ "${PORTAINER_WORKSPACE}" == "" ]]; then
    if  [[ -d "portainer-devkit" ]] || confirm; then
      PORTAINER_WORKSPACE=$(pwd)
    else
      exit 1
    fi
  fi

  echo "Workspace path: $PORTAINER_WORKSPACE in Host"
  echo "DEV_MODE=${DEV_MODE}"
}

start_workspace() {
  [[ "${DEV_MODE}" == "true" ]] && local tag=":dev"

  # start the init container to start portainer-workspace container
  docker run --rm -it \
    --name portainer-workspace-init \
    -e "DEV_MODE=${DEV_MODE}" \
    -e "DEVKIT_DEBUG=${DEVKIT_DEBUG}" \
    -e "PORTAINER_WORKSPACE=${PORTAINER_WORKSPACE}" \
    -v "${PORTAINER_WORKSPACE}:/home/workspace/devkit" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    "mcpacino/portainer-devkit-workspace${tag}" \
    /devkit/start_portainer_workspace.sh
}

init_workspace() {
  # init the workspace (clone repos, init git, etc.)
  # as entry.sh has no tty attached, init workspace here indested of in entry.sh 
  docker exec -it -u devkit:devkit portainer-workspace /devkit/init_portainer_workspace.sh
}

init_workspace_path
start_workspace
init_workspace
