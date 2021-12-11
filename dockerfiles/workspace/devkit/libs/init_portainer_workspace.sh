#!/usr/bin/env bash

source /devkit/libs/init_git.sh
source /devkit/libs/clone_repos.sh
source /devkit/libs/backup.sh
source /devkit/libs/start_portainer_workspace.sh

restore_backup
init_git
clone_repos
backup
start_portainer_workspace