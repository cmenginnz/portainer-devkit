#!/usr/bin/env bash

cmd_run() {
  debug "[cmd_run.sh] [cmd_run()] I_AM_IN=$I_AM_IN"

  if [[ $I_AM_IN == "$I_AM_IN_TARGET" ]]; then
    MSG0="'devkit.sh run' is not supported to run in current environment"
    MSG1=$(msg_fail)
    echo "MSG1" && false
  elif [[ $I_AM_IN == "$I_AM_IN_WORKSPACE" ]]; then
    _do_cmd_run
  else
    # I am in HOST
    #ensure_network && ensure_workspace && rpc workspace
    echo "I am in HOST"
  fi
}


_do_cmd_run() {
  if [[ $PROJECT == "portainer" ]]; then
    run_portainer
  elif [[ $PROJECT == "agent" ]]; then
    echo "run "
    do_run
  elif [[ $PROJECT == "edge-agent" ]]; then
    # I am in HOST
    #ensure_network && ensure_workspace && rpc workspace
    echo
  fi
}