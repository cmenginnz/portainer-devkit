#!/usr/bin/env bash

rpc_kill_dlv() {
  ( sshpass -p $SSH_PASSWORD ssh root@$TARGET_IP pkill dlv >/dev/null 2>&1 && sleep 1 ) || true
}
