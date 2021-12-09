#!/usr/bin/env bash

cmd_run() {
  _do_cmd_run
}


_do_cmd_run() {
  if [[ $PROJECT == "portainer" ]]; then
    run_portainer
  elif [[ $PROJECT == "agent" ]]; then
    run_agent
  elif [[ $PROJECT == "edge" ]]; then
    run_agent
  fi
}