#!/usr/bin/env bash

_show_portainer_urls_devkit() {
  echo
  echo "http://localhost:$PORTAINER_HTTP_PORT_IN_DEVKT"
  echo "https://localhost:$PORTAINER_HTTPS_PORT_IN_DEVKT"
}

_show_portainer_urls_k8s() {
  echo
  echo "http://localhost:$PORTAINER_HTTP_PORT_IN_K8S"
  echo "https://localhost:$PORTAINER_HTTPS_PORT_IN_K8S"
}

_run_portainer_in_k8s() {
  ensure_webpack &&
  build_portainer &&
  ensure_k8s &&
  ensure_k8s_agent &&
  rsync_portainer &&
  dlv_portainer &&
  _show_portainer_urls_k8s
}

_run_portainer_in_devkit() {
  ensure_webpack &&
  build_portainer &&
  rsync_portainer &&
  dlv_portainer &&
  _show_portainer_urls_devkit
}

run_portainer() {
  if [[ $TARGET == "k8s" ]]; then
    _run_portainer_in_k8s
  else
    _run_portainer_in_devkit
  fi
}
