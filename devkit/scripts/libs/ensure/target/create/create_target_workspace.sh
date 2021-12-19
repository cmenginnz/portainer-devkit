#!/usr/bin/env bash

# PORTAINER_WORKSPACE: the absolution workspace path in host
create_target_workspace() {
  debug "using image: ${IMAGE_NAME_WORKSPACE}"

  docker run -d --rm \
    --name $TARGET_NAME_WORKSPACE \
    --hostname portainer-workspace \
    --network $NETWORK_NAME \
    -e DEVKIT_DEBUG=$DEVKIT_DEBUG \
    -e DEV_MODE="${DEV_MODE}" \
    --ip "${TARGET_IP_WORKSPACE}" \
    -p 0.0.0.0:3000:3000 \
    -p "0.0.0.0:$PORTAINER_PORT_HTTP_WORKSPACE:$PORTAINER_PORT_HTTP_WORKSPACE" \
    -p "0.0.0.0:$PORTAINER_PORT_HTTPS_WORKSPACE:$PORTAINER_PORT_HTTPS_WORKSPACE" \
    -v "${PORTAINER_WORKSPACE}:${MOUNT_POINT}" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    "${IMAGE_NAME_WORKSPACE}"  # >>"${STDOUT}"
}
