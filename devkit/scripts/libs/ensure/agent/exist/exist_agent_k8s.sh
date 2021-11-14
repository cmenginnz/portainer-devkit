#!/usr/bin/env bash

exist_agent_k8s() {
  kubectl get deployment -n portainer portainer-agent >>"$STDOUT" 2>&1
}