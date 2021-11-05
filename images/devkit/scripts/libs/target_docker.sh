#!/usr/bin/env bash

#
# target
#
target_docker_exist() {
  docker container inspect "$TARGET_DOCKER_NAME" >>$STDOUT 2>&1
}

start_target_docker() {
  docker run --privileged -d --rm \
    -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
    --name "$TARGET_DOCKER_NAME" \
    --network "$NETWORK_NAME" \
    --ip "$TARGET_IP" \
    -p "$DLV_PORT":"$DLV_PORT" \
    docker:dind
}

wait_target_docker() {
  wait_for_target_up "Docker" "$TARGET_DOCKER_NAME"
}

ensure_dind_docker() {
  MSG1="⭐️ Finding Target Docker..."
  MSG2="✅ Found Target Docker"
  MSG3="✅ Not found Target Docker"
  MSG4="⭐️ Starting Target Docker..."
  MSG5="✅ Created Target Docker"
  MSG6="❌ Failed to start Target Docker"

  (echo && echo "$MSG1" && target_docker_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo "$MSG4" && start_target_docker && wait_target_docker && echo "$MSG5") ||
  (echo "$MSG6" && false)
}


#
# agent container
#
docker_agent_container_exist() {
  docker exec \
    -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
    "$TARGET_DOCKER_NAME" \
      docker container inspect portainer-agent \
    >>"$STDOUT" 2>&1
}


start_docker_agent_container() {
  docker exec -e DEVKIT_DEBUG="$DEVKIT_DEBUG" "$TARGET_DOCKER_NAME" \
    docker run -d --pull always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    -v portainer_agent_data:/data \
    --restart always \
    --hostname portainer-agent \
    --name portainer-agent \
    -e SSH_PASSWORD=root \
    -e DEVKIT_DEBUG="$DEVKIT_DEBUG" \
    --publish mode=host,target=22,published=22 \
    --publish mode=host,target=80,published=80 \
    --publish mode=host,target=9001,published=9001 \
    --publish mode=host,target="$DLV_PORT",published="$DLV_PORT" \
    mcpacino/portainer-devkit-agent:dev
}


ensure_docker_agent_container() {
  MSG1="⭐️ Finding Agent Container..."
  MSG2="✅ Found Agent Container"
  MSG3="✅ Not found Agent Container"
  MSG4="⭐️ Starting Agent Container..."
  MSG5="✅ Created Agent Container"
  MSG6="❌ Failed to start Agent Container"

  (echo && echo "$MSG1" && docker_agent_container_exist && echo "$MSG2") ||
  (echo "$MSG3" && echo "$MSG4" && start_docker_agent_container && wait_for_sshd_up "$TARGET_IP" && echo "$MSG5") ||
  (echo "$MSG6" && false)
}


#
# start agent in target
#
start_agent_in_target_docker() {
  scp_agent_to_target "$TARGET_IP"

  sshpass -p "root" ssh root@"$TARGET_IP" /app/start-agent-dlv.sh "$TARGET_IP" "$DLV_PORT" "$TARGET" "$AGENT_TYPE" "$EDGE_KEY"
}


ensure_target_docker() {
  TARGET_IP=$1
  DLV_PORT=$2
  TARGET=$3         # k8s (ignored)
  AGENT_TYPE=$4     # agent|edge-agent
  EDGE_KEY=$5       # optional

  debug "[target_docker.sh] [ensure_target_docker()] args='$*'"
  ensure_dind_docker &&
  ensure_docker_agent_container &&
  start_agent_in_target_docker
}
