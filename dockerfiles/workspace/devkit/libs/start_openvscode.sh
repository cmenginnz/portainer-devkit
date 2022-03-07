#!/usr/bin/env bash

VSCODE_PORT=3000
start_openvscode() {
  tmux new-session -d -s misc -n vscode \
  $OPENVSCODE_SERVER_ROOT/bin/openvscode-server --without-connection-token --host 0.0.0.0 --port "${VSCODE_PORT}"
}
