#!/usr/bin/env bash

exist_agent_docker() {
  docker exec \
    "$TARGET_NAME_DOCKER" \
      docker container inspect "${AGENT_NAME_DOCKER}"  >>"${STDOUT}" 2>&1
}

