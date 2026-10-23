#!/usr/bin/env bash
# (Re)start the eww bar. Called by i3 with exec_always, so it runs on every reload.
eww kill >/dev/null 2>&1
eww daemon
eww open bar
