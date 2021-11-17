#!/usr/bin/env bash

_show_portainer_urls() {
  echo
  echo "http://localhost:"\${"PORTAINER_PORT_HTTP_${TARGET^^}}"
  echo "https://localhost:$PORTAINER_PORT_HTTPS_WORKSPACE"
}

_show_portainer_urls_k8s() {
  echo
  echo "http://localhost:$PORTAINER_PORT_HTTP_K8S"
  echo "https://localhost:$PORTAINER_PORT_HTTPS_K8S"
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
