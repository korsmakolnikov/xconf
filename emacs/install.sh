#!/bin/bash

init_target="$HOME/.emacs.d/init.el"
init_source="$HOME/xconf/emacs/init.el"
modules_target="$HOME/.emacs.d/modules"
modules_source="$HOME/xconf/emacs/modules/"

if [ -f "$init_target" ]; then
  rm "$init_target"
fi

if [ -d "$modules_target" ]; then
  rm -rf "$modules_target"
fi

ln -s "$init_source" "$init_target"
eval "ls -s $modules_source $modules_target"
