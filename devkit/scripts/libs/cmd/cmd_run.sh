#!/usr/bin/env bash

cmd_run() {
  debug "[cmd_run.sh] [cmd_run()] I_AM_IN=$I_AM_IN"

  if [[ $I_AM_IN == "$I_AM_IN_TARGET" ]]; then
    MSG1="$E_CROSS 'devkit.sh run' is not supported to run in current environment"
    echo "MSG1" && false
  elif [[ $I_AM_IN == "$I_AM_IN_DEVKIT" ]]; then
    _do_cmd_run
  else
    # I am in HOST
    #ensure_network && ensure_devkit && rpc devkit
    echo "I am in HOST"
  fi
}


_do_cmd_run() {
  if [[ $PROGRAM == "portainer" ]]; then
    run_portainer
  elif [[ $PROGRAM == "agent" ]]; then
    echo "run "
    do_run
  elif [[ $PROGRAM == "edge-agent" ]]; then
    # I am in HOST
    #ensure_network && ensure_devkit && rpc devkit
    echo
  fi
}