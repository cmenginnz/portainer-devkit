#!/usr/bin/env bash

_inspect_workspace() {
  docker container inspect $TARGET_WORKSPACE_NAME >>$STDOUT 2>&1
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
    --name $TARGET_WORKSPACE_NAME \
    --network $NETWORK_NAME \
    -e DEVKIT_DEBUG=$DEVKIT_DEBUG \
    --ip $TARGET_IP_WORKSPACE \
    -p 3000:3000 \
    -p "$PORTAINER_PORT_HTTP_WORKSPACE:$PORTAINER_PORT_HTTP_WORKSPACE" \
    -p "$PORTAINER_PORT_HTTPS_WORKSPACE:$PORTAINER_PORT_HTTPS_WORKSPACE" \
    -p "$PORTAINER_DLV_PORT_WORKSPACE:$PORTAINER_DLV_PORT_WORKSPACE" \
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