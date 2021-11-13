#!/usr/bin/env bash

_do_dlv_portainer() {
  debug "[dlv_portainer.sh] [_do_dlv_portainer] DLV_PORT=$DLV_PORT"
  debug "[dlv_portainer.sh] [_do_dlv_portainer] DATA_PATH=$DATA_PATH"

  mkdir -p $DATA_PATH

  /app/dlv --listen=0.0.0.0:"$DLV_PORT" --headless=true --api-version=2 --check-go-version=false --only-same-user=false \
     exec /app/portainer -- --data "$DATA_PATH" --assets /app

  ps -ef | grep dlv | grep listen
}

dlv_portainer() {
  MSG0="Start Portainer"
  MSG1=$(msg_ing)
  MSG2=$(msg_ok)
  MSG3=$(msg_fail)

  echo && echo "$MSG1" &&
  (_do_dlv_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}