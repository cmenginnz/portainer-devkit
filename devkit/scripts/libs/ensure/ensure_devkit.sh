#!/usr/bin/env bash

_inspect_workspace() {
  docker container inspect $WORKSPACE_NAME >>$STDOUT 2>&1
}

_check_workspace() {
  MSG1="⭐️ Checking Workspace..."
  MSG2="✅ Found Workspace"
  MSG3="✅ Not Found Workspace"

  echo && echo "$MSG1" &&
  (_inspect_workspace && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

_do_create_workspace() {
  docker run -d --rm \
    --name $WORKSPACE_NAME \
    --network $NETWORK_NAME \
    -e DEVKIT_DEBUG=$DEVKIT_DEBUG \
    --ip $WORKSPACE_IP \
    -p 3000:3000 \
    -p "$PORTAINER_HTTP_PORT_IN_DEVKT:$PORTAINER_HTTP_PORT_IN_DEVKT" \
    -p "$PORTAINER_HTTPS_PORT_IN_DEVKT:$PORTAINER_HTTPS_PORT_IN_DEVKT" \
    -p "$PORTAINER_DLV_PORT_IN_WORKSPACE:$PORTAINER_DLV_PORT_IN_WORKSPACE" \
    -v "$WORKSPACE_PATH:/home/workspace" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    mcpacino/portainer-devkit-workspace:dev \
    >>$STDOUT
}

_create_workspace() {
  MSG1="⭐️Creating Workspace..."
  MSG2="✅ Created Workspace"
  MSG3="❌ Failed to Create Workspace"

  echo "$MSG1" &&
  (_do_create_workspace && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

# only be called in HOST
ensure_workspace() {
  _check_workspace || _create_workspace
}