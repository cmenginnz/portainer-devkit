#!/usr/bin/env bash

_do_create_target_docker() {
  docker run -d --rm --privileged \
    --name "${TARGET_NAME_DOCKER}" \
    --network "${NETWORK_NAME}" \
    --ip "${TARGET_IP_DOCKER}" \
    -p "${DLV_PORT_AGENT_DOCKER}":"${DLV_PORT_AGENT_DOCKER}" \
    -e DEVKIT_DEBUG="${DEVKIT_DEBUG}" \
    docker:dind \
    >>"${STDOUT}"
}

create_target_docker() {
  _do_create_target_docker && wait_for_target_up
}