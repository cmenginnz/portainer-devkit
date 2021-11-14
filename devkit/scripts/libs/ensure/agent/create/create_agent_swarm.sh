#!/usr/bin/env bash

_do_create_agent_swarm() {
  docker exec "$TARGET_NAME_SWARM" \
    docker service create \
      --name "${AGENT_NAME_SWARM}" \
      --hostname "${AGENT_NAME_SWARM}" \
      --network portainer_agent_network \
      --mode global \
      --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
      --mount type=bind,src=//var/lib/docker/volumes,dst=/var/lib/docker/volumes \
      --mount type=bind,src=//,dst=/host \
      --mount type=volume,src=portainer_agent_data,dst=/data \
      --publish mode=host,target=22,published=22 \
      --publish mode=host,target=9001,published=9001 \
      --publish mode=host,target=80,published=80 \
      --publish mode=host,target="${DLV_PORT_AGENT_SWARM}",published="${DLV_PORT_AGENT_SWARM}" \
      -e SSH_PASSWORD="${SSH_PASSWORD}" \
      mcpacino/portainer-devkit-agent:dev  >>"$STDOUT"
}

create_agent_swarm() {
  _do_create_agent_swarm
}