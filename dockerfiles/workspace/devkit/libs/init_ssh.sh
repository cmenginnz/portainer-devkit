#!/usr/bin/env bash

init_ssh() {
  mkdir ~/.ssh
  echo "StrictHostKeyChecking accept-new" >> ~/.ssh/config
}