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
  _rsync_portainer_to_k8s &&
  _dlv_portainer_in_k8s &&
  _show_portainer_urls_k8s

#  TARGET_IP="$TARGET_K8S_IP"
#  ensure_kind_k8s &&
#  ensure_agent_pod "$TARGET_K8S_IP" &&
#  rsync_portainer_to_target "$TARGET_K8S_IP" "$PROJECT_ROOT_PATH" &&
#  ask_k8s_start_portainer "$PORTAINER_DLV_PORT_IN_K8S" "$DATA_PATH" &&
#  show_portainer_urls_k8s
}


#_run_portainer_ensure_k8s() {
#  if [[ $TARGET == "k8s" ]]; then
#    ensure_k8s && ensure_k8s_agent
#  fi
#}


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
#  ensure_webpack &&
#  build_portainer &&
#  _run_portainer_ensure_k8s &&

}

