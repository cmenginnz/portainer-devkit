#!/usr/bin/env bash

init_username() {
  groupadd docker -g 998
  usermod openvscode-server -l devkit -d /home/workspace -G docker -s /usr/bin/bash
  groupmod openvscode-server -n devkit
  echo "devkit:portainer" | chpasswd
  echo devkit ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/devkit
}
