#!/usr/bin/env bash

debug() {
  [[ $DEVKIT_DEBUG == "true" ]] && echo "$E_MSG $E_BUG $(date "+%X") $*"
}

_do_msg() {
  echo "$E_MSG️ $MSG0 $1"
}

msg_ing() {
  _do_msg "$E_ING"
}

msg_ok() {
  _do_msg "$E_OK"
}

msg_warn() {
  _do_msg "$E_WARN"
}

msg_fail() {
  _do_msg "$E_FAIL"
}


_do_ssh() {
  sshpass -p "$SSH_PASSWORD" ssh root@"$TARGET_IP" true >>$STDOUT 2>&1
}

wait_sshd() {
  #  until nc -w 1 "$TARGET_IP" 22; do

  MSG0="Check SSH Server"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)

  echo && echo $MSG1
  until _do_ssh; do
    sleep 5;
    echo $MSG1
  done
  echo $MSG2
}

scp_agent_to_target() {
  local TARGET_IP=$1

  sshpass -p "root" scp /go/bin/dlv root@"$TARGET_IP":/usr/bin/ >>"$STDOUT" 2>&1
  sshpass -p "root" scp /agent/dist/agent root@"$TARGET_IP":/app/
  sshpass -p "root" scp /scripts/libs/start-agent-dlv.sh root@"$TARGET_IP":/app/
}

rsync_portainer_to_target() {
  local TARGET_IP=$1
  local PROJECT_ROOT_PATH=$2

  sshpass -p "root" rsync /app/public/* root@192.168.100.1:/app/public/
  sshpass -p "root" scp /go/bin/dlv root@"$TARGET_IP":/usr/bin/ >>"$STDOUT" 2>&1
  sshpass -p "root" scp "${PROJECT_ROOT_PATH}/dist/portainer" root@"$TARGET_IP":/app/
  sshpass -p "root" scp /scripts/libs/start-portainer-dlv.sh root@"$TARGET_IP":/app/
}

_ls_docker_sock() {
  docker exec "$TARGET_NAME" ls -l /var/run/docker.sock >>$STDOUT 2>&1
}

wait_for_target_up() {
  MSG0="Wait for ${TARGET^}"
  local MSG1=$(msg_ing)
  local MSG2=$(msg_ok)

  until _ls_docker_sock; do
    echo "${MSG1}"
    sleep 3;
  done
  echo "${MSG2}"
}

kill_dlv() {
  (killall dlv >/dev/null 2>&1 && sleep 1) || true
}
