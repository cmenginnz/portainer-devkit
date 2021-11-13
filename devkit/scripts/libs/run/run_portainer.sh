#!/usr/bin/env bash

_show_portainer_urls_workspace() {
  echo
  echo "http://localhost:$PORTAINER_PORT_HTTP_WORKSPACE"
  echo "https://localhost:$PORTAINER_PORT_HTTPS_WORKSPACE"
}

_show_portainer_urls_k8s() {
  echo
  echo "http://localhost:$PORTAINER_PORT_HTTP_K8S"
  echo "https://localhost:$PORTAINER_PORT_HTTPS_K8S"
}

run_portainer() {
  ensure_webpack &&
  build_portainer &&
  ensure_target &&
  ensure_agent &&
  wait_for_sshd_up &&
  rsync_portainer &&
  rpc_dlv &&
  _show_portainer_urls_k8s
}
