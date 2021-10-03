#!/usr/bin/env bash

debug() {
  [[ $DEVKIT_DEBUG == "true" ]] && echo "🐞" `date` "$*"
}


wait_for_sshd_up() {
  local TARGET_IP=$1

  until nc -w 1 "$TARGET_IP" 22; do
    echo '⭐️ Waiting for SSH Server...'
    sleep 3;
  done
}

scp_agent_to_target() {
  local TARGET_IP=$1

  sshpass -p "root" scp /go/bin/dlv root@"$TARGET_IP":/usr/bin/ >>"$STDOUT" 2>&1
  sshpass -p "root" scp /agent/dist/agent root@"$TARGET_IP":/app/
  sshpass -p "root" scp /scripts/libs/start-agent-dlv.sh root@"$TARGET_IP":/app/
}

rsync_portainer_to_target() {
  local TARGET_IP=$1
  local PORTAINER_SRC_PATH=$2

  sshpass -p "root" rsync /app/public/* root@192.168.100.1:/app/public/
  sshpass -p "root" scp /go/bin/dlv root@"$TARGET_IP":/usr/bin/ >>"$STDOUT" 2>&1
  sshpass -p "root" scp "${PORTAINER_SRC_PATH}/dist/portainer" root@"$TARGET_IP":/app/
  sshpass -p "root" scp /scripts/libs/start-portainer-dlv.sh root@"$TARGET_IP":/app/
}

ls_docker_sock() {
  local TARGET_CONTAINER_NAME=$1

  docker exec -e DEVKIT_DEBUG=$DEVKIT_DEBUG "$TARGET_CONTAINER_NAME" ls -l /var/run/docker.sock >>$STDOUT 2>&1
}

wait_for_target_up() {
  local TARGET_NAME=$1
  local TARGET_CONTAINER_NAME=$2

  MSG1="⭐️ Waiting for Target $TARGET_NAME..."
  until ls_docker_sock $TARGET_CONTAINER_NAME; do
    echo $MSG1
    sleep 1;
  done
}

calc_target_ip() {
  local TARGET=$1   # k8s|swarm|docker

  local TARGET_IP=""

  case $TARGET in
    k8s)
      TARGET_IP="$TARGET_K8S_IP"
      ;;
    swarm)
      TARGET_IP="$TARGET_SWARM_IP"
      ;;
    docker)
      TARGET_IP="$TARGET_DOCKER_IP"
      ;;
  esac

  echo "$TARGET_IP"
}

calc_agent_dlv_port() {
  local TARGET=$1   # k8s|swarm|docker

  local DLV_PORT=""

  case $TARGET in
    k8s)
      DLV_PORT="$AGENT_DLV_PORT_IN_K8S"
      ;;
    swarm)
      DLV_PORT="$AGENT_DLV_PORT_IN_SWARM"
      ;;
    docker)
      DLV_PORT="$AGENT_DLV_PORT_IN_DOCKER"
      ;;
  esac

  echo "$DLV_PORT"
}

kill_dlv() {
  (killall dlv >/dev/null 2>&1 && sleep 1) || true
}
