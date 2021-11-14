#!/usr/bin/env bash

_do_create_swarm() {
  docker run --privileged -d --rm \
    --name "$TARGET_NAME_SWARM" \
    --network "${NETWORK_NAME}" \
    --ip "${TARGET_IP_SWARM}" \
    -p ${DLV_PORT_AGENT_SWARM}:${DLV_PORT_AGENT_SWARM} \
    -e DEVKIT_DEBUG=${DEVKIT_DEBUG} \
    docker:dind  >>"$STDOUT"
}

_init_target_to_swarm() {
  docker exec "$TARGET_SWARM_NAME" docker swarm init >>"$STDOUT"
}

_create_swarm_network() {
  docker exec "$TARGET_NAME_SWARM" \
    docker network create \
      --driver overlay \
      portainer_agent_network &&
  sleep 3
}

create_target_swarm() {
  _do_create_swarm && wait_for_target_up && _init_target_to_swarm && _create_swarm_network
}