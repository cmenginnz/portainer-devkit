#!/usr/bin/env bash

cmd_dlv() {
  debug "[cmd_dlv.sh] [cmd_dlv()] ENV_VAR_LIST=$ENV_VAR_LIST"

  if [ "$SUB_CMD" == "exec" ]; then
    dlv_exec
  elif [ "$SUB_CMD" == "kill" ]; then
    kill_dlv
  fi
}
