#!/usr/bin/env bash

USER_HOME="/home/workspace"
MOUNT_POINT="/home/workspace/src"

backup() {
  [[ -f "$USER_HOME/.gitconfig" ]] && cp "$USER_HOME/.gitconfig" "$MOUNT_POINT"
  [[ -f "$USER_HOME/.git-credentials" ]] && cp "$USER_HOME/.git-credentials" "$MOUNT_POINT"
}

restore_backup() {
  [[ -f "$MOUNT_POINT/.gitconfig" ]] && cp "$MOUNT_POINT/.gitconfig" "$USER_HOME"
  [[ -f "$MOUNT_POINT/.git-credentials" ]] && cp "$MOUNT_POINT/.git-credentials" "$USER_HOME"
}