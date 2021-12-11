#!/usr/bin/env bash

#set -x

init_git() {
  git config --global credential.helper store

  if [[ -z "$(git config --global user.name)" ]]; then
    read -p "Input gitconfig.user.name: " -r
    git config --global user.name "$REPLY"
  fi

  if [[ -z "$(git config --global user.email)" ]]; then
    read -p "Input gitconfig.user.email: " -r
    git config --global user.email "$REPLY"
  fi
}
