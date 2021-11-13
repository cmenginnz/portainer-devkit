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

_run_portainer_k8s() {
  ensure_webpack &&
  build_portainer &&
  ensure_k8s &&
  ensure_k8s_agent &&
  rsync_portainer &&
  rpc_dlv &&
  _show_portainer_urls_k8s
}

_run_portainer_workspace() {
  ensure_webpack &&
  build_portainer &&
  rsync_portainer &&
  rpc_dlv &&
  _show_portainer_urls_workspace
}

run_agent() {
  if [[ $TARGET == "k8s" ]]; then
    _run_portainer_k8s
  else
    _run_portainer_workspace
  fi
}
