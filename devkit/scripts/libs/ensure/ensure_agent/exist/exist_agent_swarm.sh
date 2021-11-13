#!/usr/bin/env bash

exist_agent_swarm() {
  docker exec "$TARGET_SWARM_NAME" \
    docker service inspect portainer_agent
  >>"$STDOUT" 2>&1
}