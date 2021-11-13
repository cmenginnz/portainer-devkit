#!/usr/bin/env bash

exist_agent_docker() {
  docker exec \
    "$TARGET_DOCKER" \
      docker container inspect portainer-agent \
  >>"$STDOUT" 2>&1
}

