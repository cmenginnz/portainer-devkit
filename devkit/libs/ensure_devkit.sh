inspect_devkit() {
  docker container inspect $DEVKIT_NAME >>$STDOUT 2>&1
}

check_devkit() {
  MSG1="⭐️ Checking Devkit..."
  MSG2="✅ Found Devkit"
  MSG3="✅ Not Found Devkit"

  echo && echo "$MSG1" &&
  (inspect_devkit && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

do_create_devkit() {
  docker run -d --rm --pull always \
    --name $DEVKIT_NAME \
    --network $NETWORK_NAME \
    -e DEVKIT_DEBUG=$DEVKIT_DEBUG \
    --ip $DEVKIT_IP \
    -p "$PORTAINER_HTTP_PORT_IN_DEVKT:$PORTAINER_HTTP_PORT_IN_DEVKT" \
    -p "$PORTAINER_HTTPS_PORT_IN_DEVKT:$PORTAINER_HTTPS_PORT_IN_DEVKT" \
    -p "$PORTAINER_DLV_PORT_IN_DEVKIT:$PORTAINER_DLV_PORT_IN_DEVKIT" \
    -v "$WORKSPACE/../portainer:/portainer" \
    -v "$WORKSPACE/../data-ce:/data-ce" \
    -v "$WORKSPACE/../portainer-ee:/portainer-ee" \
    -v "$WORKSPACE/../data-ee:/data-ee" \
    -v "$WORKSPACE/../agent:/agent" \
    -v "$WORKSPACE/../portainer-devkit/images/devkit/scripts:/scripts" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    mcpacino/portainer-devkit:latest \
    >>$STDOUT
}

create_devkit() {
  MSG1="⭐️Creating Devkit '$DEVKIT_NAME'..."
  MSG2="✅ Created Devkit"
  MSG3="❌ Failed to Create Devkit"

  echo "$MSG1" &&
  (do_create_devkit && echo "$MSG2") ||
  (echo "$MSG3" && false)
}

ensure_devkit() {
  check_devkit || create_devkit
}