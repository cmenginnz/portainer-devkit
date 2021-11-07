#!/usr/bin/env bash

_inspect_devkit() {
  docker container inspect $DEVKIT_NAME >>$STDOUT 2>&1
}

_check_devkitcheck_devkit() {
  MSG1="⭐️ Checking Devkit..."
  MSG2="✅ Found Devkit"
  MSG3="✅ Not Found Devkit"

  echo && echo "$MSG1" &&
  (_inspect_devkit && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

_do_create_devkit() {
  docker run -d --rm \
    --name $DEVKIT_NAME \
    --network $NETWORK_NAME \
    -e DEVKIT_DEBUG=$DEVKIT_DEBUG \
    --ip $DEVKIT_IP \
    -p 3000:3000 \
    -p "$PORTAINER_HTTP_PORT_IN_DEVKT:$PORTAINER_HTTP_PORT_IN_DEVKT" \
    -p "$PORTAINER_HTTPS_PORT_IN_DEVKT:$PORTAINER_HTTPS_PORT_IN_DEVKT" \
    -p "$PORTAINER_DLV_PORT_IN_DEVKIT:$PORTAINER_DLV_PORT_IN_DEVKIT" \
    -v "$WORKSPACE_PATH:/home/workspace" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    mcpacino/portainer-devkit:dev \
    >>$STDOUT
}

_create_devkit() {
  MSG1="⭐️Creating Devkit '$DEVKIT_NAME'..."
  MSG2="✅ Created Devkit"
  MSG3="❌ Failed to Create Devkit"

  echo "$MSG1" &&
  (_do_create_devkit && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

# only be called in HOST
ensure_devkit() {
  _check_devkitcheck_devkit || _create_devkit
}