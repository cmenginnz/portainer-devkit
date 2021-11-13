#!/usr/bin/env bash

create_target_docker() {
  docker run -d --rm --privileged \
    --name "$TARGET_DOCKER_NAME" \
    --network "$NETWORK_NAME" \
    --ip "$TARGET_IP_DOCKER" \
    -p "$DLV_PORT_AGENT_DOCKER":"$DLV_PORT_AGENT_DOCKER" \
    -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
    docker:dind \
    >>$STDOUT
}