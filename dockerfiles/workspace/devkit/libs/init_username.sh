#!/usr/bin/env bash

init_username() {
  groupadd docker -g 998
  usermod openvscode-server -l devkit -d /home/workspace -aG root,docker -s /usr/bin/bash
  groupmod openvscode-server -n devkit
  echo "devkit:${SSH_PASSWORD:-portainer}" | chpasswd

  # allow user devkit to run ALL(3) commands without password from ALL(1) host as ALL(2) users
  echo "devkit ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devkit

  # allow user devkit inherit environment variables(i.e. GOPATH) from user root
  echo "Defaults        !env_reset" > /etc/sudoers.d/root

  # disable secure path of sudo so that user devkit has the full PATH list
  sed -i 's/Defaults/#Defaults/g' /etc/sudoers

  # allow user devkit to write docker sock
  chmod g+w /var/run/docker.sock
}
