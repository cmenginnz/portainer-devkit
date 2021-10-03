#!/usr/bin/env bash

run_portainer_in_devkit() {
  PORTAINER_VER=$1   # ce|ee
  TARGET=$2          # devkit|k8s

  debug "[run_portainer_in_devkit()] PORTAINER_VER=$PORTAINER_VER TARGET=$TARGET DEVKIT_DEBUG=$DEVKIT_DEBUG"

  docker exec -e DEVKIT_DEBUG="$DEVKIT_DEBUG" -it "$DEVKIT_NAME" /scripts/start-portainer.sh "$PORTAINER_VER" "$TARGET"
}

# Usage
# run_portainer ce|ee devkit|k8s
# 1. ensure devkit is up
# 2. let devkit run portainer in devkit or k8s
run_portainer() {
  PORTAINER_VER=$1   # ce|ee
  TARGET=$2          # devkit|k8s

  ensure_network &&
  ensure_devkit &&
  run_portainer_in_devkit "$PORTAINER_VER" "$TARGET"
}