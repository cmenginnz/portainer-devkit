#!/usr/bin/env bash

# This CLI will be copied to the K8s target

# Usage
# start-portainer-dlv.sh DLV_PORT /data-ce|/data-ee

# arguments
DLV_PORT=$1
DATA_PATH=$2      # /data-ce | /data-ee

kill_dlv() {
  (killall dlv >/dev/null 2>&1 && sleep 1) || true
}

start_portainer_dlv() {
  mkdir -p "$DATA_PATH"
  dlv --listen=0.0.0.0:"$DLV_PORT" --headless=true --api-version=2 --check-go-version=false --only-same-user=false exec \
      /app/portainer -- --data "$DATA_PATH" --assets /app
}

kill_dlv
start_portainer_dlv
