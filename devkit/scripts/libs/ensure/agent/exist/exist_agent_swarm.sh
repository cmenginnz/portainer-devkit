#!/usr/bin/env bash

exist_agent_swarm() {
  docker exec "$TARGET_NAME_SWARM" \
    docker service inspect portainer_agent >>"$STDOUT" 2>&1
}