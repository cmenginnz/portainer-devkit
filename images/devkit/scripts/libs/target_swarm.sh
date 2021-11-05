#!/usr/bin/env bash

#
# target
#
target_swarm_exist() {
  docker container inspect "$TARGET_SWARM_NAME" >>"$STDOUT" 2>&1
}

start_target_swarm() {
  docker run --privileged -d --rm \
    --name "$TARGET_SWARM_NAME" \
    --network "$NETWORK_NAME" \
    --ip "$TARGET_IP" \
    -p ${DLV_PORT}:${DLV_PORT} \
    -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
    docker:dind
}

init_target_to_swarm() {
  docker exec "$TARGET_SWARM_NAME" docker swarm init >>"$STDOUT"
}

create_swarm_network() {
  docker exec "$TARGET_SWARM_NAME" \
    docker network create \
    --driver overlay \
    portainer_agent_network &&
  sleep 3
}

wait_target_swarm() {
  wait_for_target_up "Swarm" "$TARGET_SWARM_NAME"
}

ensure_dind_swarm() {
  MSG1="⭐️ Finding Target Swarm..."
  MSG2="✅ Found Target Swarm"
  MSG3="✅ Not found Target Swarm"
  MSG4="⭐️ Starting Target Swarm..."
  MSG5="✅ Created Target Swarm"
  MSG6="❌ Failed to start Target Swarm"

  (echo && echo "$MSG1" && target_swarm_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo "$MSG4" && start_target_swarm && wait_target_swarm && init_target_to_swarm && create_swarm_network && echo "$MSG5") ||
  (echo "$MSG6" && false)
}

agent_service_exist() {
  docker exec -e DEVKIT_DEBUG="$DEVKIT_DEBUG" "$TARGET_SWARM_NAME" \
    docker service inspect portainer_edge_agent >>"$STDOUT" 2>&1
}

#
# agent container
#
start_agent_service() {
  docker exec "$TARGET_SWARM_NAME" \
    docker service create \
      --name portainer_edge_agent \
      --network portainer_agent_network \
      --mode global \
      --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
      --mount type=bind,src=//var/lib/docker/volumes,dst=/var/lib/docker/volumes \
      --mount type=bind,src=//,dst=/host \
      --mount type=volume,src=portainer_agent_data,dst=/data \
      --publish mode=host,target=22,published=22 \
      --publish mode=host,target=9001,published=9001 \
      --publish mode=host,target=80,published=80 \
      --publish mode=host,target="$DLV_PORT",published="$DLV_PORT" \
      -e SSH_PASSWORD=root \
      -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
      mcpacino/portainer-devkit-agent:dev
}

ensure_agent_service() {
  MSG1="⭐️ Finding Agent Service..."
  MSG2="✅ Found Agent Service"
  MSG3="✅ Not found Agent Service"
  MSG4="⭐️ Starting Agent Service..."
  MSG5="✅ Created Agent Service"
  MSG6="❌ Failed to start Agent Service"

  (echo && echo "$MSG1" && agent_service_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo "$MSG4" && start_agent_service && wait_for_sshd_up "$TARGET_IP" && echo "$MSG5") ||
  (echo "$MSG6" && false)
}

#
# start agent in target
#
start_agent_in_target_swarm() {
  scp_agent_to_target "$TARGET_IP"

  sshpass -p "root" ssh root@"$TARGET_IP" /app/start-agent-dlv.sh "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
}


ensure_target_swarm() {
  TARGET_IP=$1
  DLV_PORT=$2
  TARGET=$3         # k8s (ignored)
  AGENT_TYPE=$4     # agent|edge-agent
  EDGE_KEY=$5       # optional

  debug "[target_swarm.sh] [ensure_target_swarm()] args='$*'"

  ensure_dind_swarm &&
  ensure_agent_service &&
  start_agent_in_target_swarm
}
