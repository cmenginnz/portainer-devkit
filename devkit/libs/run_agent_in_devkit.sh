#!/usr/bin/env bash

run_agent_in_devkit() {
  TARGET=$1       # docker|swarm|k8s
  AGENT_TYPE=$2   # agent | edge-agent
  EDGE_KEY=$3     # EDGE_KEY

  docker exec -e DEVKIT_DEBUG=$DEVKIT_DEBUG -it $DEVKIT_NAME /scripts/start-agent.sh "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
}

# Usage
# run_agent agent|edge-agent docker|swarm|k8s EDGE_KEY
# 1. ensure devkit is up
# 2. let devkit be in charge of running agent
run_agent() {
  TARGET=$1       # docker|swarm|k8s
  AGENT_TYPE=$2   # agent | edge-agent
  EDGE_KEY=$3     # EDGE_KEY

  ensure_network &&
  ensure_devkit &&
  run_agent_in_devkit "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
}