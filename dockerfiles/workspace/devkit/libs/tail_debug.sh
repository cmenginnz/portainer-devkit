#!/usr/bin/env bash

STDOUT="/tmp/portainer-devkit.log"

tail_debug() {
  touch "${STDOUT}"

  tmux new-window -d -t misc -n debug \
  tail -f "${STDOUT}"
}
