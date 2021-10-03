#!/usr/bin/env bash

# This CLI will be copied to the K8s target
# Usage
# start-agent-dlv.sh TARGET_IP DLV_PORT k8s|swarm|docker agent|edge-agent [EDGE_KEY]

# arguments
TARGET_IP=$1
DLV_PORT=$2
TARGET=$3         # k8s|swarm|docker
AGENT_TYPE=$4     # agent|edge-agent
EDGE_KEY=$5       # optional

echo "[start-agent-dlv.sh] args='$*'"

kill_dlv() {
  (killall dlv >/dev/null 2>&1 && sleep 1) || true
}

export_env_vars() {
  [[ $TARGET == "k8s" ]]   && export AGENT_CLUSTER_ADDR=portainer-agent-headless
  [[ $TARGET == "swarm" ]] && export AGENT_CLUSTER_ADDR=tasks.portainer_edge_agent

  if [[ $AGENT_TYPE == "edge-agent" ]]; then
    export EDGE=1
    export EDGE_INSECURE_POLL=1
    export EDGE_ID=portainer-builder-edge-id
    export EDGE_KEY=$EDGE_KEY
  fi
}

start_agent() {
  echo && echo "⭐️ Staring Agent..."

  export_env_vars

  cd /app
  tmux new -d dlv --listen=0.0.0.0:$DLV_PORT --headless=true --api-version=2 --check-go-version=false --only-same-user=false exec /app/agent
  (ps -ef | grep dlv | grep listen && echo '✅ Started Agent') || (echo '❌ Failed to Start Agent' && false)
}

kill_dlv
start_agent
