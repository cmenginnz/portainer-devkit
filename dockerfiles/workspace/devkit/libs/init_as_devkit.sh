#!/usr/bin/env bash

source /devkit/libs/backup.sh
source libs/start_openvscode.sh

restore_backup
start_openvscode
