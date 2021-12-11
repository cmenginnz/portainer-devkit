#!/usr/bin/env bash

USER_HOME="/home/workspace"
MOUNT_POINT="/home/workspace/src"

[[ -f "$MOUNT_POINT/.gitconfig" ]] && cp "$MOUNT_POINT/.gitconfig" "$USER_HOME"
[[ -f "$MOUNT_POINT/.git-credentials" ]] && cp "$MOUNT_POINT/.git-credentials" "$USER_HOME"
