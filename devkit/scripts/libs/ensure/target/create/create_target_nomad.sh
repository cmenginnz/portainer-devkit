#!/usr/bin/env bash

_do_create_target_nomad() {
  docker run -d --rm --privileged \
    --name "${TARGET_NAME_NOMAD}" \
    --network "${NETWORK_NAME}" \
    --ip "${TARGET_IP_NOMAD}" \
    -e DEVKIT_DEBUG="${DEVKIT_DEBUG}" \
    -p 4646:4646 \
    mcpacino/nomad:latest \
    >>"${STDOUT}"
}

#    sleep 999999 \
#    docker:dind \
#    -p "${DLV_PORT_AGENT_DOCKER}":"${DLV_PORT_AGENT_DOCKER}" \
#    docker:20.10.12-dind-alpine3.15 \

create_target_nomad() {
  _do_create_target_nomad && wait_for_target_up
}
