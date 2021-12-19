#!/usr/bin/env bash

exist_agent_swarm() {
  docker exec "$TARGET_NAME_SWARM" \
    docker service inspect "${AGENT_NAME_SWARM}" >>"${STDOUT}" 2>&1
}