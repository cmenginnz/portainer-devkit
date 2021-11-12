#!/usr/bin/env bash

cmd_dlv() {
  debug "[cmd_dlv.sh] [cmd_dlv()] I_AM_IN=$I_AM_IN ENV_VAR_LIST=$ENV_VAR_LIST"

  if [ "$SUB_CMD" == "exec" ]; then
    _cmd_dlv_exec
  elif [ "$SUB_CMD" == "kill" ]; then
    kill_dlv
  fi
}

_cmd_dlv_exec() {
  if [ "$PROGRAM" == "portainer" ]; then
    dlv_portainer
  elif [ "$SUB_CMD" == "agent" ]; then
    dlv_agent
  fi
}

