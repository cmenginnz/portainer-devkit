#!/usr/bin/env bash

WORKSPACE_ROOT_PATH=${PORTAINER_WORKSAPCE:-$PWD}

docker run --rm \
  --name portainer-devkit-init \
  -e USER_UID_GID=`id -u`:`id -g` \
  -v $WORKSPACE_ROOT_PATH:/home/workspace \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  mcpacino/portainer-devkit:dev \
  init &&
$WORKSPACE_ROOT_PATH/portainer-devkit/devkit/scripts/devkit.sh ensure network &&
$WORKSPACE_ROOT_PATH/portainer-devkit/devkit/scripts/devkit.sh ensure devkit