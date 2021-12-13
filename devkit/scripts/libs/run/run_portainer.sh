#!/usr/bin/env bash

_show_portainer_urls() {
  echo

  eval local port=\$PORTAINER_PORT_HTTP_${TARGET^^}
  MSG0="http://localhost:${port} "
  MSG1=$(msg_info)
  echo "$MSG1"

  eval local port=\$PORTAINER_PORT_HTTPS_${TARGET^^}
  MSG0="https://localhost:${port}"
  MSG1=$(msg_info)
  echo "$MSG1"
}

run_portainer() {
  ensure_webpack &&
  build_project &&
  ensure_target &&
  ensure_agent &&
  wait_sshd &&
  rsync_project &&
  rpc_dlv_exec &&
  _show_portainer_urls
}
