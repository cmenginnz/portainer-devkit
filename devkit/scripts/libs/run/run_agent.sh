#!/usr/bin/env bash

run_agent() {
  build_project &&
  ensure_target &&
  ensure_agent &&
  wait_sshd &&
  rsync_project &&
  rpc_dlv_exec
}
