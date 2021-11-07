#!/usr/bin/env bash

cd /workspace

git clone https://github.com/portainer/portainer.git
git clone https://github.com/portainer/agent.git
git clone https://github.com/mcpacino/portainer-devkit.git

mkdir data-ce
mkdir data-ee

mkdir portainer/.vscode
ln -s ../portainer-devkit/devkit portainer/
ln -s ../devkit/vscode/tasks.json portainer/.vscode/
ln -s ../devkit/vscode/portainer/launch.json portainer/.vscode/

mkdir portainer-ee/.vscode
ln -s ../portainer-devkit/devkit portainer-ee/
ln -s ../devkit/vscode/tasks.json portainer-ee/.vscode/
ln -s ../devkit/vscode/portainer/launch.json portainer-ee/.vscode/

mkdir agent/.vscode
ln -s ../portainer-devkit/devkit agent/
ln -s ../devkit/vscode/tasks.json agent/.vscode/
ln -s ../devkit/vscode/agent/launch.json agent/.vscode/

chown "${USER_UID_GID}" -R portainer agent portainer-devkit data-ce data-ee
