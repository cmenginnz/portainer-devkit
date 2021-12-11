#!/usr/bin/env bash

MOUNT_POINT="/home/workspace/src"

start_portainer_workspace() {
  ${MOUNT_POINT}/portainer-devkit/devkit/scripts/devkit.sh ensure workspace "${PORTAINER_WORKSPACE}"
}