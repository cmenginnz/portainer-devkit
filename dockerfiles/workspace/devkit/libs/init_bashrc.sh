#!/usr/bin/env bash

init_bashrc() {
  sudo -u devkit cp /devkit/bashrc/bashrc /home/workspace/devkit/.bashrc
  sudo -u devkit cp /devkit/bashrc/dir_colors /home/workspace/devkit/.dir_colors
}