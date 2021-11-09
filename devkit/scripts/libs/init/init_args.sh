#!/usr/bin/env bash

init_args() {
  debug "[init_args.sh] [init_args()] args=$*"

  ARGS="$@"
  COMMAND="$1"

  if [ $COMMAND == "run" ]; then
    PROGRAM=$2
    TARGET=$3
    EDGE_KEY=$4
  fi

  if [ $COMMAND == "dlv" ]; then
    SUB_CMD=$2
    PROGRAM=$2
  fi
}

