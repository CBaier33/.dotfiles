#!/usr/bin/env bash

## A custom script I wrote to display user and hostname in status bar.
## Needs to be mv'd to plugins/tmux/scripts

export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

main()
{
  echo "$(whoami)@$(hostname)"
}

main
