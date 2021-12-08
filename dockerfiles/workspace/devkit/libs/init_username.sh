#!/usr/bin/env bash

init_username() {
  groupadd docker -g 998
  usermod openvscode-server -l devkit -d /home/workspace -G docker -s /usr/bin/bash
  groupmod openvscode-server -n devkit
  echo "devkit:portainer" | chpasswd
  echo devkit ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/devkit

  chown -R devkit:devkit /app

  # disable secure path of sudo so that user devkit has the full PATH list
  sed -i 's/Defaults/#Defaults/g' /etc/sudoers
}
