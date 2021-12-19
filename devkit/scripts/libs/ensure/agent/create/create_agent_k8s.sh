#!/usr/bin/env bash

_do_create_agent_k8s() {
  debug "using image: ${IMAGE_NAME_AGENT}"

  local yaml_file="${CURRENT_FILE_PATH}/libs/portainer-k8s-agent-builder.yaml"

  cat "${yaml_file}" | sed "s#${IMAGE_NAME_AGENT_DEFAULT}#${IMAGE_NAME_AGENT}#g" | grep "image:" >>${MUTE}

  cat "${yaml_file}" | sed "s#${IMAGE_NAME_AGENT_DEFAULT}#${IMAGE_NAME_AGENT}#g" | kubectl apply -f - >>"${STDOUT}"
}

create_agent_k8s() {
  _do_create_agent_k8s
}