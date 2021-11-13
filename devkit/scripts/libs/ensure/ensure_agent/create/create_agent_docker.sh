#!/usr/bin/env bash

create_agent_docker() {
  docker exec "$TARGET_DOCKER_NAME" \
    docker run -d --pull always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    -v portainer_agent_data:/data \
    --restart always \
    --hostname portainer-docker-agent \
    --name portainer-agent \
    -e SSH_PASSWORD=${SSH_PASSWORD} \
    --publish mode=host,target=22,published=22 \
    --publish mode=host,target=80,published=80 \
    --publish mode=host,target=9001,published=9001 \
    --publish mode=host,target="${DLV_PORT_AGENT_DOCKER}",published="${DLV_PORT_AGENT_DOCKER}" \
    mcpacino/portainer-devkit-agent:dev
  >>$STDOUT
}

