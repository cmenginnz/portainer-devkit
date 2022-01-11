#!/usr/bin/env bash

rpc_dlv_kill() {
  [[ "$PROJECT" == "portainer" ]] && local killee="/portainer" || local killee="/agent"
  ( sshpass -p $SSH_PASSWORD ssh $SSH_USER_REAL@$TARGET_IP pkill $killee >/dev/null 2>&1 && sleep 1 ) || true
}
