#!/usr/bin/env bash

source /devkit/libs/backup.sh
source libs/start_openvscode.sh
source libs/tail_debug.sh

restore_backup
start_openvscode
tail_debug
