#!/usr/bin/env bash

_show_portainer_urls() {
  echo

  eval local port=\$PORTAINER_PORT_HTTP_${TARGET^^}
  echo http://localhost:${port}

  eval local port=\$PORTAINER_PORT_HTTPS_${TARGET^^}
  echo "https://localhost:${port}"
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
