#!/usr/bin/env bash

VSCODE_PORT=3000
start_openvscode() {
  tmux new-session -d -s misc -n vscode \
  $OPENVSCODE_SERVER_ROOT/server.sh --port "${VSCODE_PORT}"
}
