#!/usr/bin/env bash

create_target_workspace() {
  debug "using image: ${IMAGE_NAME_WORKSPACE}"

  docker run -d --rm \
    --name $TARGET_NAME_WORKSPACE \
    --network $NETWORK_NAME \
    -e DEVKIT_DEBUG=$DEVKIT_DEBUG \
    --ip $TARGET_IP_WORKSPACE \
    -p 3000:3000 \
    -p "$PORTAINER_PORT_HTTP_WORKSPACE:$PORTAINER_PORT_HTTP_WORKSPACE" \
    -p "$PORTAINER_PORT_HTTPS_WORKSPACE:$PORTAINER_PORT_HTTPS_WORKSPACE" \
    -p "$DLV_PORT_PORTAINER_WORKSPACE:$DLV_PORT_PORTAINER_WORKSPACE" \
    -v "$WORKSPACE_PATH:/home/workspace" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    "${IMAGE_NAME_WORKSPACE}"  >>$STDOUT
}
