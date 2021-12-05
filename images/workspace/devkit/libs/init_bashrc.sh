#!/usr/bin/env bash

init_bashrc() {
  sudo -u devkit cp /fancy_bashrc/bashrc /home/workspace/.bashrc
  sudo -u devkit cp /fancy_bashrc/dir_colors /home/workspace/.dir_colors
}