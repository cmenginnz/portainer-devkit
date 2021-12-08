#!/usr/bin/env bash

start_openvscode() {
  sudo -u devkit $OPENVSCODE_SERVER_ROOT/server.sh --port 3000
}
