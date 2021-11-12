#!/usr/bin/env bash

WORKSPACE_ROOT_PATH=${PORTAINER_WORKSAPCE:-$PWD}

# mcdebug
WORKSPACE_ROOT_PATH=/home/simon/workspace

docker run --rm \
  --name portainer-workspace-init \
  -e USER_UID_GID=`id -u`:`id -g` \
  -v $WORKSPACE_ROOT_PATH:/home/workspace \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  mcpacino/portainer-devkit-workspace:dev \
  init &&
$WORKSPACE_ROOT_PATH/portainer-devkit/devkit/scripts/devkit.sh ensure network &&
$WORKSPACE_ROOT_PATH/portainer-devkit/devkit/scripts/devkit.sh ensure workspace