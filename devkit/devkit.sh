#!/usr/bin/env bash

# CLI Usage
# devkit.sh run portainer devkit|k8s
# devkit.sh run agent docker|swarm|k8s
# devkit.sh run edge-agent docker|swarm|k8s EDGE_KEY

COMMAND=$1
PROGRAM=$2
TARGET=$3
EDGE_KEY=$4

echo "🏁️ $COMMAND $PROGRAM in $TARGET..." && echo

# init is shared between several files in this project. Sync it all the time.
init() {
  CURRENT_FILE_PATH=$(dirname $0)   # /scripts/libs
  WORKSPACE=$(dirname $CURRENT_FILE_PATH) # /home/simon/go/src/portainer
  [[ "$WORKSPACE" == *portainer-ee ]] && PORTAINER_VER=ee || PORTAINER_VER=ce

  source "${CURRENT_FILE_PATH}/libs/consts.sh"
  source "${CURRENT_FILE_PATH}/libs/helpers.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure_network.sh"
  source "${CURRENT_FILE_PATH}/libs/ensure_devkit.sh"
  source "${CURRENT_FILE_PATH}/libs/run_portainer_in_devkit.sh"
  source "${CURRENT_FILE_PATH}/libs/run_agent_in_devkit.sh"

  debug "[devkit.sh] [init()] CURRENT_FILE_PATH=$CURRENT_FILE_PATH"
  debug "[devkit.sh] [init()] WORKSPACE=$WORKSPACE"
  debug "[devkit.sh] [init()] PORTAINER_VER=$PORTAINER_VER"
}
init
debug "[devkit.sh] args=\"$*\""


run() {
  case $PROGRAM in
  portainer)
    run_portainer $PORTAINER_VER "$TARGET"
    ;;
  agent)
    run_agent "$TARGET" "$PROGRAM"
    ;;
  edge-agent)
    run_agent "$TARGET" "$PROGRAM" "$EDGE_KEY"
    ;;
  *)
    echo "❌ Unknown Program $PROGRAM"
    exit 2
    ;;
  esac
}

clean() {
  docker stop "$TARGET_K8S_CONTAINER_NAME" >>"$STDOUT" 2>&1  &&  docker rm "$TARGET_K8S_CONTAINER_NAME" >>"$STDOUT" 2>&1
  docker stop "$TARGET_SWARM" >>"$STDOUT" 2>&1
  docker stop "$TARGET_DOCKER_NAME" >>"$STDOUT" 2>&1
  docker stop "$DEVKIT_NAME" >>"$STDOUT" 2>&1
  echo "Removed all targets"
}

main() {
  case $COMMAND in
  run)
    run
    ;;
  clean)
    clean
    ;;
  *)
    echo "❌ Unknown command"
    exit 1
    ;;
  esac
}

main