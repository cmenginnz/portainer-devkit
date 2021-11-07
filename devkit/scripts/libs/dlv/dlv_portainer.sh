#!/usr/bin/env bash

_do_dlv_portainer() {
  debug "[start-portainer.sh] [do_start_portainer_dlv] PROJECT_ROOT_PATH=$PROJECT_ROOT_PATH DATA_PATH=$DATA_PATH PORTAINER_DLV_PORT_IN_DEVKIT=$PORTAINER_DLV_PORT_IN_DEVKIT"

#  ln -f -s ${PROJECT_ROOT_PATH}/dist/public /app

  tmux new -d -s backend-devkit \
    /app/dlv --listen=0.0.0.0:"$PORTAINER_DLV_PORT_IN_DEVKIT" --headless=true --api-version=2 --check-go-version=false --only-same-user=false \
    exec /app/portainer -- --data "$DATA_PATH" --assets /app

  ps -ef | grep dlv | grep listen
}

dlv_portainer() {
  MSG1="⭐️ Starting Portainer..."
  MSG2="✅ Started Portainer"
  MSG3="❌ Failed to Start Portainer"

  echo && echo "$MSG1" &&
  (_do_dlv_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}