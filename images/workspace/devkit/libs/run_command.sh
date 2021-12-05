#!/usr/bin/env bash

run_command() {
  # run cmd then exit
  if [[ ! -z "$*" ]]; then
    sudo -u devkit \
      DEV_MODE="$DEV_MODE" \
      DEVKIT_DEBUG="$DEVKIT_DEBUG" \
      PORTAINER_WORKSPACE="$PORTAINER_WORKSPACE" \
      $*
    exit $?
  fi
}
