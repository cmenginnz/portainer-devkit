#!/usr/bin/env bash

rpc_dlv_kill() {
  ( sshpass -p $SSH_PASSWORD ssh $SSH_USER_REAL@$TARGET_IP pkill dlv >/dev/null 2>&1 && sleep 1 ) || true
}
