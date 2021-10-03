#!/usr/bin/env bash

# CLI Usage
# start-portainer.sh ce|ee devkit|k8s

PORTAINER_VER=$1 # ce|ee
TARGET=$2        # devkit|k8s

[[ $PORTAINER_VER == "ce" ]] && PORTAINER_SRC_PATH="/portainer" || PORTAINER_SRC_PATH="/portainer-ee"
[[ $PORTAINER_VER == "ce" ]] && DATA_PATH="/data-ce" || DATA_PATH="/data-ee"

# init is shared between several files in this project. Sync it all the time.
init() {
  CURRENT_FILE_PATH=$(dirname $0)
  WORKSPACE=$(dirname "$CURRENT_FILE_PATH") # /home/simon/go/src/portainer
  [[ "$WORKSPACE" == *portainer-ee ]] && PORTAINER_VER=ee || PORTAINER_VER=ce

  source "${CURRENT_FILE_PATH}/libs/consts.sh"
  source "${CURRENT_FILE_PATH}/libs/helpers.sh"
  source "${CURRENT_FILE_PATH}/libs/target_k8s.sh"
}
init
debug "[start-portainer.sh] args='$*'"

start_frontend() {
  (
    echo '⭐️ Finding Webpack Dev Watch...' &&
      tmux ls | grep webpack-dev-watch >/dev/null &&
      echo '✅ Found Webpack Dev Watch'
  ) || ( 
    (cd ${PORTAINER_SRC_PATH} && yarn install && tmux new -s webpack-dev-watch -d yarn start:client && echo '✅ Started Webpack Dev Watch') ||
      (echo '❌ Failed to Start Webpack Dev Watch' && false)
  )
}

do_build_portainer() {
  mkdir -p ${PORTAINER_SRC_PATH}/dist
  cd ${PORTAINER_SRC_PATH}/api/cmd/portainer
  go build --installsuffix cgo --ldflags="" -gcflags="all=-N -l" -o "${PORTAINER_SRC_PATH}/dist/portainer" && cd - >/dev/null
}

build_portainer() {
  MSG1="⭐️ Building Portainer..."
  MSG2="✅ Built Portainer"
  MSG3="❌ Build Portainer"

  echo && echo "$MSG1" &&
  (do_build_portainer && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

do_start_portainer_dlv() {
  ln -f -s ${PORTAINER_SRC_PATH}/dist/public /app

  tmux new -d -s backend-devkit \
    dlv --listen=0.0.0.0:"$PORTAINER_DLV_PORT_IN_DEVKIT" --headless=true --api-version=2 --check-go-version=false --only-same-user=false \
    exec ${PORTAINER_SRC_PATH}/dist/portainer -- --data $DATA_PATH --assets /app

  ps -ef | grep dlv | grep listen
}

start_portainer_dlv() {
  MSG1="⭐️ Starting Portainer..."
  MSG2="✅ Started Portainer"
  MSG3="❌ Failed to Start Portainer"

  echo && echo "$MSG1" &&
  (do_start_portainer_dlv && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

show_portainer_urls_devkit() {
  echo
  echo "http://localhost:$PORTAINER_HTTP_PORT_IN_DEVKT"
  echo "https://localhost:$PORTAINER_HTTPS_PORT_IN_DEVKT"
}

show_portainer_urls_k8s() {
  echo
  echo "http://localhost:$PORTAINER_HTTP_PORT_IN_K8S"
  echo "https://localhost:$PORTAINER_HTTPS_PORT_IN_K8S"
}

ensure_portainer_in_devkit() {
  kill_dlv &&
  start_frontend &&
  build_portainer &&
  start_portainer_dlv &&
  show_portainer_urls_devkit
}

ensure_portainer_in_k8s() {
  TARGET_IP="$TARGET_K8S_IP"
  ensure_kind_k8s &&
  ensure_agent_pod "$TARGET_K8S_IP" &&
  rsync_portainer_to_target "$TARGET_K8S_IP" "$PORTAINER_SRC_PATH" &&
  ask_k8s_start_portainer "$PORTAINER_DLV_PORT_IN_K8S" "$DATA_PATH" &&
  show_portainer_urls_k8s
}


#
# main
#
if [[ $TARGET == "k8s" ]]; then
  ensure_portainer_in_k8s
else
  ensure_portainer_in_devkit
fi
