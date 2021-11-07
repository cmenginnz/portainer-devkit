#!/usr/bin/env bash

# CLI Usage
# start-agent.sh k8s|swarm|docker agent|edge-agent [EDGE-KEY]

# arguments
TARGET=$1     # k8s|swarm|docker
AGENT_TYPE=$2 # agent|edge-agent
EDGE_KEY=$3   # optional

# init is shared between several files in this project. Sync it all the time.
init() {
  CURRENT_FILE_PATH=$(dirname $0) # should be /scripts

  source "${CURRENT_FILE_PATH}/libs/consts.sh"
  source "${CURRENT_FILE_PATH}/libs/helpers.sh"
  source "${CURRENT_FILE_PATH}/libs/target_k8s.sh"
  source "${CURRENT_FILE_PATH}/libs/target_swarm.sh"
  source "${CURRENT_FILE_PATH}/libs/target_docker.sh"

  debug "[start-agent.sh] CURRENT_FILE_PATH='$CURRENT_FILE_PATH'"
}
init
debug "[start-agent.sh] args = '$*'"

do_build_agent() {
  mkdir -p /agent/dist
  cd /agent/cmd/agent/
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o /agent/dist/agent  && cd - >/dev/null
}

build_agent() {
  MSG1="⭐️ Building Agent..."
  MSG2="✅ Built Agent"
  MSG3="❌ Build Agent"

  echo && echo "$MSG1" &&
  (do_build_agent && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

ensure_target() {
  TARGET_IP=$(calc_target_ip "$TARGET")
  DLV_PORT=$(calc_agent_dlv_port "$TARGET")

  debug "[start-agent.sh] [start_target()] TARGET='$TARGET' TARGET_IP='$TARGET_IP' DLV_PORT='$DLV_PORT'"

  case $TARGET in
  k8s)
    ensure_target_k8s "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
    ;;
  swarm)
    ensure_target_swarm "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
    ;;
  docker)
    ensure_target_docker "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
    ;;
  esac
}

#
# main
#
build_agent &&
ensure_target
